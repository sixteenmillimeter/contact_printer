'use strict';

const cmd = require('commander');
const Arduino = require('arduino');

const printer = new Arduino();

async function configure () {
	//read command lines

}

async function run_printer () {

	await printer.connect()
	await configure();
	await

}

run_printer().then(()=>{}).catch(()=>{});
