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
const { Config } = require('./config');
const https = require('expressjs-force-https');
// const { Config } = require('./tgho_controller/tg_config');


/**@type {{
  host: string,
  port: string,
  path: string,
  protocol: string
}} */
// const config = JSON.parse(fs.readFileSync('config.json'));

if(Config.PROTOCOL === 'https'){
App.use(https());
}

App.use(cors());
App.use(express.static(path.join(__dirname, './views')));
App.use(express.urlencoded({extended: true}));
App.use(express.json())
App.use(Web);
// App.use('/apiv2', V2Api);
// App.use("/api", Api);

// 22/03/01 - Add ApiV2
App.use('/api/v2', ApiV2);


App.use((req, res, next) => res.status(404).send("404 | not found"));
App.use((req, res, next) => res.status(500).send("500 | server error"))

App.listen(Config.PORT, () => console.log(`${Config.PROTOCOL}://${Config.HOST}:${Config.PORT}`));

module.exports = App