'use strict';

const electron = require('electron');
const app = electron.app;
const BrowserWindow = electron.BrowserWindow;
const config = require('./lib/config.js');
const ac = require('./lib/arduinoCom.js');
const ttr = require('./lib/talktorender.js');

const path = require('path');
const url = require('url');

let mainWindow;

const Roll = require('./lib/roll.js');

/* app functions */

/*ipcMain.on('asynchronous-message', (event, arg) => {
	console.log(arg);  // prints "ping"
	return event.sender.send('asynchronous-reply', 'pong');
});

ipcMain.on('synchronous-message', (event, arg) => {
	console.log(arg) ; // prints "ping"
	return event.returnValue = 'pong';
});*/

let createWindow = () => {
	mainWindow = new BrowserWindow({
		width: 350, 
		height: 600
	});

	if (config.data.position) {
		let pos = config.get('position');
		mainWindow.setPosition(pos[0], pos[1]);
	}

	mainWindow.loadURL(url.format({
		pathname: path.join(__dirname, 'index.html'),
		protocol: 'file:',
		slashes: true
	}));

	mainWindow.webContents.openDevTools();

	mainWindow.on('closed', () => {
		mainWindow = null;
	});
};

let ipcBindings = () => {
	ttr.on('config', (event, args, etc) => {
		console.dir(event);
		console.dir(args);
	});
};

app.on('ready', createWindow);
app.on('window-all-closed', () => {
	config.set('position', mainWindow.getPosition());
	app.quit();
});

app.on('activate', function () {
	if (mainWindow === null) {
		createWindow();
		ipcBindings();
		ac.send('c', () => {});
	}
});

//ac.close();