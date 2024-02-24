# contact printer dev server

The purpose of this project is to host a dev server that development branches of the contact printer can post reports to after running.
This can be used for profiling the operation with different settings, hardware and conditions.
Reports will log data as it is needed without a specific goal from the outset, largely looking at speed of motors over time compared to PWM and can be used to improve performance or documentation.

The server has no frontend and simply accepts a post from the ESP32 running the contact printer and inserts the data into the SQLite database.

## Installing

Install the node dependencies for running the server.

```bash
npm install --omit=dev
```

If you would like to develop the server, install the complete set of dependencies.

```bash
npm install
```

## Running

```bash
node dist
```

## Developing

If you make changes to the Typescript in source, recompile the server code.

```bash
npm run compile
```