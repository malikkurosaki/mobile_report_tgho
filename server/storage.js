const LocalStoraget = require('node-localstorage').LocalStorage;
const storage = new LocalStoraget('./scratch');
module.exports = { storage };