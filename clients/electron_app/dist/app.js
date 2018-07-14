/*jshint browser:true*/
'use strict';
const Fingerprint2 = require('./lib/fingerprint2.js');
const ttm = require('./lib/talktomain.js');

var fp;

var onReady = function () {
	fp = new Fingerprint2().get((result, components) => {
		console.log(result);
		setTimeout(function () {
			ttm.send('config', { fingerprint : result });
		}, 2000);
	});
};


document.addEventListener('DOMContentLoaded', onReady);



/*console.log(ipcRenderer.sendSync('synchronous-message', 'ping')); // prints "pong"

ipcRenderer.on('asynchronous-reply', (event, arg) => {
  console.log(arg); // prints "pong"
});

ipcRenderer.send('asynchronous-message', 'ping');

function timeout(duration = 0) {
	return new Promise((resolve, reject) => {
		setTimeout(resolve, duration);
	})
}

var p = timeout(1000).then(() => {
	return timeout(2000);
}).then(() => {
	throw new Error("hmm");
}).catch(err => {
	return Promise.all([timeout(100), timeout(200)]);
})

*/