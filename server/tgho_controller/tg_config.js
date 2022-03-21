class Config {
    static host = 'localhost';
    static port = 3000;
    static prefix = 'api';
    static protocol = 'http';
    static version = 'v2';
    static baseUrl = '$protocol://$host:$port/$prefix/$version';
}
module.exports = { Config };