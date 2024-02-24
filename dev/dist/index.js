"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv/config");
const express_1 = __importDefault(require("express"));
const body_parser_1 = __importDefault(require("body-parser"));
const log_1 = require("./log");
const PORT = typeof process.env['PORT'] !== 'undefined' ? parseInt(process.env['PORT'], 10) : 9999;
let db;
const app = (0, express_1.default)();
const log = (0, log_1.createLog)('server');
app.use(body_parser_1.default.json());
app.use(body_parser_1.default.urlencoded({ extended: true }));
async function setup() {
    //db = new Database('./data.sqlite');
}
async function report(req, res, next) {
    //
    log.info(`Added record`);
    res.json({ success: true });
}
app.post('/', report);
async function main() {
    await setup();
    app.listen(PORT, async () => {
        log.info(`contact_printer_dev_server running on port ${PORT}`);
    });
}
main();
//# sourceMappingURL=index.js.map