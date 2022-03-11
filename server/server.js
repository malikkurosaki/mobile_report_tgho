const express = require('express');
const Api = require('./router_api');
const Web = require('./router_web');
const V2Api = require('./v2_router_api');
const App = express();
const PORT = process.env.PORT || 3100
const cors = require('cors');
const { ApiV2 } = require('./api_v2');
const fs = require('fs');
const path = require('path');

/**@type {{
  host: string,
  port: string,
  path: string,
  protocol: string
}} */
const config = JSON.parse(fs.readFileSync('config.json'));

App.use(cors());
App.use(express.static(path.join(__dirname, './views')));
App.use(express.urlencoded({extended: true}));
App.use(express.json())
App.use(Web);
App.use('/apiv2', V2Api);
App.use("/api", Api);

// 22/03/01 - Add ApiV2
App.use('/api/v2', ApiV2);


App.use((req, res, next) => res.status(404).send("404 | not found"));
App.use((req, res, next) => res.status(500).send("500 | server error"))

App.listen(config.port, () => console.log(`${config.protocol}://${config.host}:${config.port}`));

module.exports = App