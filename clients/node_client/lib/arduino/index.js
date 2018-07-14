'use strict'

const SerialPort = require('serialport')
const Readline = SerialPort.parsers.Readline
const exec = require('child_process').exec
const parser = new Readline('')
const newlineRe = new RegExp('\n', 'g')
const returnRe = new RegExp('\r', 'g')
let eventEmitter

const mcopy = {}

async function delay (ms) {
	return new Promise(resolve => {
		return setTimeout(resolve, ms)
	})
}

async function send (device, cmd) {
	return new Promise ((resolve, reject) => {
		mcopy.arduino.queue[cmd] = (ms) => {
			return resolve(ms)
		}
		return mcopy.arduino.serial[device].write(cmd, (err, results) => {
			if (err) {
				//console.error(err)
				return reject(err)
			}
			//
		})
	})
}

async function write (device, str) {
	return new Promise ((resolve, reject) => {
		mcopy.arduino.serial[device].write(str, function (err, results) {
			if (err) { 
				return reject(err)
			}
			//console.log('sent: ' + str)
			return resolve(results)
		})
	})
}

async function open (device) {
	return new Promise((resolve, reject) => {
		return mcopy.arduino.serial[device].open(error => {
			if (error) {
				return reject(error)
			}
			return resolve(true)
		})
	})
}

async function close (device) {
	return new Promise((resolve, reject) => {
		return mcopy.arduino.serial[device].close((err) => {
			if (err) {
				return reject(err)
			}
			return resolve(true)
		})
	})
}

/******
	Arduino handlers
*******/
mcopy.arduino = {
	path : {},
	known: [
		'/dev/tty.usbmodem1a161', 
		'/dev/tty.usbserial-A800f8dk', 
		'/dev/tty.usbserial-A900cebm', 
		'/dev/tty.usbmodem1a131',
		'/dev/tty.usbserial-a900f6de',
		'/dev/tty.usbmodem1a141',
		'/dev/ttyACM0',
		'COM3'
	],
	alias : {

	},
	serial : {
		connect : {},
		projector : {},
		camera : {},
		light : {}
	},
	baud : 57600,
	queue : {},
	timer : 0,
	lock : false
}

mcopy.arduino.enumerate = async function () {
	return new Promise( (resolve, reject) => {
		return SerialPort.list((err, ports) => {
			let matches = []
			if (err) {
				return reject(err)
			}
			ports.forEach(port => {
				if (mcopy.arduino.known.indexOf(port.comName) !== -1) {
					matches.push(port.comName)
				} else if ((port.manufacturer + '').toLowerCase().indexOf('arduino') !== -1) {
					matches.push(port.comName)
				}
			})
			if (matches.length === 0) {
				return reject('No USB devices found');
			} else if (matches.length > 0) {
				return resolve(matches)
			}
		})
	})
}

//commands which respond to a sent char
mcopy.arduino.send = async function (serial, cmd, res) {
	const device = mcopy.arduino.alias[serial]
	let results
	if (mcopy.arduino.lock) {
		return false
	}
	mcopy.arduino.lock = true
	await delay(mcopy.cfg.arduino.serialDelay)
	try {
		results = await send(device, cmd)
	} catch (e) {
		return console.error(e)
	}
	mcopy.arduino.lock = false
	mcopy.arduino.timer = new Date().getTime()
	return await eventEmitter.emit('arduino_send', cmd)
}

//send strings, after char triggers firmware to accept
mcopy.arduino.string = async function (serial, str) {
	const device = mcopy.arduino.alias[serial]
	let writeSuccess
	await delay(mcopy.cfg.arduino.serialDelay)
	if (typeof mcopy.arduino.serial[device].fake !== 'undefined'
		&& mcopy.arduino.serial[device].fake) {
		return mcopy.arduino.serial[device].string(str)
	} else {
		try {
			writeSuccess = await write(device, str)
		} catch (e) {
			return console.error(e)
		}
		return writeSuccess
	}
}

//respond with same char over serial when done
mcopy.arduino.end = async function (data) {
	const end = new Date().getTime()
	const ms = end - mcopy.arduino.timer
	let complete
	if (mcopy.arduino.queue[data] !== undefined) {
		mcopy.arduino.lock = false;
		//console.log('Command ' + data + ' took ' + ms + 'ms');
		complete = mcopy.arduino.queue[data](ms) //execute callback
		eventEmitter.emit('arduino_end', data)
		delete mcopy.arduino.queue[data]
	} else {
		//console.log('Received stray "' + data + '"'); //silent to user
	}
	return complete
};
mcopy.arduino.alias = function (serial, device) {
	console.log(`Making "${serial}" an alias of ${device}`)
	mcopy.arduino.alias[serial] = device
}
mcopy.arduino.connect = async function (serial, device, confirm) {
	return new Promise(async (resolve, reject) => {
		let connectSuccess
		mcopy.arduino.path[serial] = device;
		mcopy.arduino.alias[serial] = device;
		mcopy.arduino.serial[device] = new SerialPort(mcopy.arduino.path[serial], {
			autoOpen : false,
			baudRate: mcopy.cfg.arduino.baud,
			parser: parser
		})
		try {
			connectSuccess = await open(device) 
		} catch (e) {
			console.error('failed to open: ' + e)
			return reject(e)
		}
		console.log(`Opened connection with ${mcopy.arduino.path[serial]} as ${serial}`);
		if (!confirm) {
			mcopy.arduino.serial[device].on('data', async (data) => {
				let d = data.toString('utf8')
				d = d.replace(newlineRe, '').replace(returnRe, '')
				return await mcopy.arduino.end(d)
			})
		} else {
			mcopy.arduino.serial[device].on('data', async (data) => {
				let d = data.toString('utf8')
				d = d.replace(newlineRe, '').replace(returnRe, '')
				return await mcopy.arduino.confirmEnd(d)
			})
		}
		return resolve(mcopy.arduino.path[serial])
	})

}

mcopy.arduino.confirmExec = {};
mcopy.arduino.confirmEnd = function (data) {
	//console.dir(data)
	if (data === mcopy.cfg.arduino.cmd.connect
		|| data === mcopy.cfg.arduino.cmd.proj_identifier
		|| data === mcopy.cfg.arduino.cmd.cam_identifier
		|| data === mcopy.cfg.arduino.cmd.light_identifier
		|| data === mcopy.cfg.arduino.cmd.proj_light_identifier
		|| data === mcopy.cfg.arduino.cmd.proj_cam_light_identifier
		|| data === mcopy.cfg.arduino.cmd.proj_cam_identifier ) {
		mcopy.arduino.confirmExec(null, data);
		mcopy.arduino.confirmExec = {};
	}
}

mcopy.arduino.verify = async function () {
	return new Promise(async (resolve, reject) => {
		const device = mcopy.arduino.alias['connect']
		let writeSuccess
		mcopy.arduino.confirmExec = function (err, data) {
			if (data === mcopy.cfg.arduino.cmd.connect) {
				return resolve(true)
			} else {
				return reject('Wrong data returned')
			}
		}
		await delay(mcopy.cfg.arduino.serialDelay)
		try {
			writeSuccess = await send(device, mcopy.cfg.arduino.cmd.connect)
		} catch (e) {
			return reject(e)
		}
		return resolve(writeSuccess)
	})
}

mcopy.arduino.distinguish = async function () {
	return new Promise(async (resolve, reject) => {
		const device = mcopy.arduino.alias['connect']
		let writeSuccess
		let type
		mcopy.arduino.confirmExec = function (err, data) {
			if (data === mcopy.cfg.arduino.cmd.proj_identifier) {
				type = 'projector'
			} else if (data === mcopy.cfg.arduino.cmd.cam_identifier) {
				type = 'camera'
			} else if (data === mcopy.cfg.arduino.cmd.light_identifier) {
				type = 'light'
			} else if (data === mcopy.cfg.arduino.cmd.proj_light_identifier) {
				type = 'projector,light'
			} else if (data === mcopy.cfg.arduino.cmd.proj_cam_light_identifier) {
				type = 'projector,camera,light'
			} else if (data === mcopy.cfg.arduino.cmd.proj_cam_identifier) {
				type = 'projector,camera'
			}
			return resolve(type)
		}
		await delay(mcopy.cfg.arduino.serialDelay)
		try {
			writeSuccess = await send(device, mcopy.cfg.arduino.cmd.mcopy_identifier)
		} catch (e) {
			console.error(e)
			return reject(e)
		}
	})
}

mcopy.arduino.close = async function (callback) {
	const device = mcopy.arduino.alias['connect']
	let closeSuccess
	try {
		closeSuccess = await close(device)
	} catch (e) {
		return console.error(e)
	}
	return closeSuccess
};

mcopy.arduino.fakeConnect = async function (serial) {
	//console.log('Connecting to fake arduino...');
	const device = '/dev/fake'
	mcopy.arduino.alias[serial] = device
	mcopy.arduino.serial[device] = {
		write : function (cmd, cb) {
			const t = {
				c : mcopy.cfg.arduino.cam.time + mcopy.cfg.arduino.cam.delay,
				p : mcopy.cfg.arduino.proj.time + mcopy.cfg.arduino.proj.delay
			}
			let timeout = t[cmd]
			let end
			if (typeof timeout === 'undefined') timeout = 10
			mcopy.arduino.timer = +new Date()
			setTimeout(() => {
				mcopy.arduino.end(cmd)
				return cb()
			}, timeout)

		}, 
		string : async function (str) {
			//do nothing
			return true
		},
		fake : true
	};
	//console.log('Connected to fake arduino! Not real! Doesn\'t exist!');
	return true
}

if (typeof module !== 'undefined' && module.parent) {
	/*module.exports = function (cfg, ee) {
		eventEmitter = ee
		mcopy.cfg = cfg
		return mcopy.arduino
	}*/
}

class Arduino {
	
}

module.exports = Arduino;