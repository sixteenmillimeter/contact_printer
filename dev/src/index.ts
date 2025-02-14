import 'dotenv/config';
import express from 'express';
import { Express, Request, Response, NextFunction } from 'express'
import fs from 'fs/promises';
import { join } from 'path';
import { Database } from 'sqlite3';
import bodyParser from 'body-parser';
import multer from 'multer';
import { v4 as uuid } from 'uuid';
import { createLog } from './log'
import type { Logger } from 'winston';

const PORT : number = typeof process.env['PORT'] !== 'undefined' ? parseInt(process.env['PORT'], 10) : 9999;

let db : Database;
const app : Express = express();
const log : Logger = createLog('server');

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));


async function setup () {
	//db = new Database('./data.sqlite');
}

async function report (req : Request, res: Response, next : NextFunction) {
	//
	log.info(`Added record`);
	res.json({ success : true });
}

app.post('/', report);


async function main () {
	await setup();
	app.listen(PORT, async () => {
		log.info(`contact_printer_dev_server running on port ${PORT}`);
	});
}

main();