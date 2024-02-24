'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
exports.createLog = void 0;
/** @module log */
/** Wrapper for winston that tags streams and optionally writes files with a simple interface. */
/** Module now also supports optional papertrail integration, other services to follow */
const winston_1 = require("winston");
const { SPLAT } = require('triple-beam');
const { isObject } = require('lodash');
const APP_NAME = process.env.APP_NAME || 'default';
let winstonPapertrail;
function formatObject(param) {
    if (isObject(param)) {
        return JSON.stringify(param);
    }
    return param;
}
const all = (0, winston_1.format)((info) => {
    const splat = info[SPLAT] || [];
    const message = formatObject(info.message);
    const rest = splat.map(formatObject).join(' ');
    info.message = `${message} ${rest}`;
    return info;
});
const myFormat = winston_1.format.printf(({ level, message, label, timestamp }) => {
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
function createLog(label, filename = null) {
    const tports = [new (winston_1.transports.Console)()];
    const fmat = winston_1.format.combine(all(), winston_1.format.label({ label }), winston_1.format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss.SSS' }), winston_1.format.colorize(), myFormat);
    let papertrailOpts;
    if (filename !== null) {
        tports.push(new (winston_1.transports.File)({ filename }));
    }
    return (0, winston_1.createLogger)({
        format: fmat,
        transports: tports
    });
}
exports.createLog = createLog;
module.exports = { createLog };
//# sourceMappingURL=log.js.map