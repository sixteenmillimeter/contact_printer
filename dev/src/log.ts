'use strict'

/** @module log */
/** Wrapper for winston that tags streams and optionally writes files with a simple interface. */
/** Module now also supports optional papertrail integration, other services to follow */

import { format, transports, createLogger } from 'winston';
const { SPLAT } = require('triple-beam');
const { isObject } = require('lodash');

const APP_NAME : string = process.env.APP_NAME || 'default';

let winstonPapertrail;

function formatObject (param : any) {
  if (isObject(param)) {
    return JSON.stringify(param);
  }
  return param;
}

const all = format((info : any) => {
    const splat = info[SPLAT] || [];
    const message = formatObject(info.message);
    const rest = splat.map(formatObject).join(' ');
    info.message = `${message} ${rest}`;
    return info;
});

const myFormat = format.printf(({ level, message, label, timestamp } : any) => {
  return `${timestamp} [${label}] ${level}: ${message}`;
});

/**
* Returns a winston logger configured to service
*
* @param {string} label Label appearing on logger
* @param {string} filename Optional file to write log to 
*
* @returns {object} Winston logger
*/
export function createLog (label : string, filename : string = null) {
    const tports : any[] = [ new (transports.Console)() ];
    const fmat : any = format.combine(
        all(),
        format.label({ label }),
        format.timestamp({format: 'YYYY-MM-DD HH:mm:ss.SSS'}),
        format.colorize(), 
        myFormat,
    );
    let papertrailOpts : any;

    if (filename !== null) {
        tports.push( new (transports.File)({ filename }) );
    }
    
    return createLogger({
        format : fmat,
        transports : tports
    });
}

module.exports = { createLog };