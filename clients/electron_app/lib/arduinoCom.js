'use strict';

const SerialPort = require('serialport');
const parser = SerialPort.parsers.readline("\n");
const delay = 15;
const baud = 57600;

let waiting = false;
let waitCb;

class arduinoCom {
	constructor () {
		this.port = {};
		this.path = '';

		SerialPort.list((err, ports) => {		
			if (err) {
				return console.error(err);
			}
			for (let i = 0; i < ports.length; i++) {
				if ((ports[i].manufacturer + '').toLowerCase().indexOf('arduino') !== -1) {
					this.path = ports[i].comName;
					break;
				}
			}
			if (this.path === '') {
				return console.error('No arduino found');
			}
			console.log(`Connecting to ${this.path}...`);
			this.port = new SerialPort(this.path, {
	  			baudRate: baud,
	  			parser : parser,
	  			autoOpen: false
			});
			this.port.open((err) => {
				if (err) {
					return console.error(err);
				}
				console.log(`Connected to ${this.path} @ ${baud} baud`);
				this.port.on('data', this.dataCb);
			});
		});
	}
	dataCb (data = '{}') {
		data = JSON.parse(data);
		if (waiting) {
			waitCb(null, data);
			waiting = false;
		}
	}
	send (ch = 'z', callback = null, nowait = false) {
		if (!waiting && !nowait) {
			waitCb = callback;
			waiting = true;
		} else if (nowait) {
			waiting = false;
			if (callback !== null) {
				return callback(null, {});
			}
		} else {
			return callback('Port is currently in use');
		}
		setTimeout(() => {
			this.port.write(ch);
		}, delay);
		return false;
	}
	close (callback) {
		console.log('Closing ${this.path}');
		this.port.close(callback);
	}
}

module.exports = new arduinoCom();