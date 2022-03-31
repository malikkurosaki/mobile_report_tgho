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
const LocalStorage = require('node-localstorage').LocalStorage;
const localStorage = new LocalStorage('./scratch');

// if (Config.PROTOCOL === 'https') {
//   App.use(https);
// }

// App.use(async (req, res, next) => {
//   const db = await r.connect({ host: "localhost" });
//   r.dbList().run(db).then(async (dbs) => {
//     if (!dbs.includes('tgho')) {
//       await r.dbCreate('tgho').run(db);
//       console.log('Database tgho created');
//     }
//     await r.db('tgho').tableList().run(db).then(async (tables) => {
//       if (!tables.includes('dashboard')) {
//         await r.db('tgho').tableCreate('dashboard').run(db);
//         console.log('Table dashboard created');
//       }
//     });

//   })
//   req.db = db;
//   // r.dbect().then(async (db) => {
//   //   r.dbList().then(async (dbs) => {

//   //   })
//   //   req.db = db;
//   //   next();
//   // }).catch((err) => {
//   //   console.log(err);
//   // });

// });

App.use(cors());
App.use(express.static(path.join(__dirname, './views')));
App.use(express.urlencoded({ extended: true }));
App.use(express.json())
App.use(Web);
// App.use('/apiv2', V2Api);
// App.use("/api", Api);

// 22/03/01 - Add ApiV2
App.use('/api/v2', ApiV2);


App.use((req, res, next) => res.status(404).send("404 | not found"));
App.use((req, res, next) => res.status(500).send("500 | server error"))

App.listen(Config.PORT, () => console.log(`${Config.PROTOCOL}://${Config.HOST}:${Config.PORT}`));

module.exports = { App };