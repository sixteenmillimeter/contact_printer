'use strict';
const {ipcMain} = require('electron');

class TTR {
	constructor () {
		this.listeners = [];
	}
	send (service = null, obj = {}) {
		let json = JSON.stringify(obj);
		return ipcMain.send(service, json);
	}
	on (service = null, cb = ()=>{}) {
		let listener = (event, args, etc) => {
			return cb(event, args, etc);
		};
		this.listeners.push(service);
		return ipcMain.on(service, listener);
	}
}

module.exports = new TTR();