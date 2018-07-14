'use strict';
const {ipcRenderer} = require('electron');

class TTM {
	constructor () {
		this.listeners = [];
	}
	send (service = null, obj = {}) {
		let json = JSON.stringify(obj);
		return ipcRenderer.send(service, json);
	}
	on (service = null, cb = ()=>{}) {
		let listener = (event, args, etc) => {
			return cb(event, args, etc);
		};
		this.listeners.push(service);
		return ipcRenderer.on(service, listener);
	}
}

module.exports = new TTM();