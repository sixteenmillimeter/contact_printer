'use strict';
const fs = require('fs');

class Config {
	constructor () {
		this.configPath = './data/config.json';
		if (fs.existsSync(this.configPath)) {
			this.data = JSON.parse(fs.readFileSync(this.configPath, 'utf8'));
		} else {
			this.data = {};
			this.store();
		}
	}
	get (key) {
		if (this.data[key]) {
			return this.data[key];
		} else {
			return null;
		}
	}
	set (key, val) {
		this.data[key] = val;
		this.store();
	}
	store () {
		fs.writeFileSync(this.configPath, JSON.stringify(this.data), 'utf8');
	}
}

module.exports = new Config();