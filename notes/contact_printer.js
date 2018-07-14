var RPM = 15;
var RPS = RPM / 60; //Rotations per second, from 15RPM
var D = 31.27; //mm, Diameter of core (daylight spool here) 32, or 31.5
//var D_END = 87.16;
var THICKNESS = 0.11938; //mm, 16mm = 0.0047in thick
var PITCH = 7.6;
var TOTAL = 33 * 1000;

var roll = {};

//R = √(36000 × 0.005/π + 32) = √(57.30 + 9) = 8.14 inches.
roll.diameter = function (length) {
	'use strict';
	var r = Math.sqrt(((length * THICKNESS) / Math.PI) + Math.pow(D / 2, 2));
	return 2 * r;
};

roll.length = function (d) {
	'use strict';
	var len = Math.PI * (Math.pow(d / 2, 2) - Math.pow(D / 2, 2));
	return len / THICKNESS;
};

//mm/s
roll.speed = function (d) {
	'use strict';
	var mm = d * Math.PI;
	return mm * RPS;
};

var job = {};
		
job.pmw = {};			   //15 7.5
/*
job.pmw.values = [255, 55];
job.pmw.rps = [0.1100917431, 0.06629834254];
*/

job.state = {
	motor_pwm : 255,
	current_rps : RPS,
	start_time : 0,
	end_time : 0,
	estimated_time : 0
};

job.begin = function () {
	'use strict';
	job.state.start_time = +new Date();
	//job pins set
	job.state.estimated_time = 0;
};

job.simulate = function () {
	'use strict';


};




job.begin();
console.dir(job.state);
