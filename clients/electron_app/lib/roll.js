'use strict';
const RPM = 15;
const RPS = RPM / 60; //Rotations per second, from 15RPM
const D = 31.27; //mm, Diameter of core (daylight spool here) 32, or 31.5
const THICKNESS = 0.11938; //mm, 16mm = 0.0047in thick
const PITCH = 7.6;

class Roll {
	constructor () {
		//var D_END = 87.16;
		this.TOTAL = 33 * 1000;
	}
	//R = √(36000 × 0.005/π + 32) = √(57.30 + 9) = 8.14 inches.
	diameter (length = 0) {
		const val = ((length * THICKNESS) / Math.PI) + Math.pow(D / 2, 2);
		const r = Math.sqrt(val);
		return 2 * r;
	}
	length (d = 0) {
		const len = Math.PI * (Math.pow(d / 2, 2) - Math.pow(D / 2, 2));
		return len / THICKNESS;
	}
	//mm/s
	speed (d = 0) {
		const mm = d * Math.PI;
		return mm * RPS;
	}
}

module.exports = Roll;