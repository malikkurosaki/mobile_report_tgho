const path = require('path')
var subscript = require('markdown-it-sub');
var superscript = require('markdown-it-sup');

/**
 * @type {import('webpack').Configuration}
 */
const config = {
    entry: "/src/main.js",
    output: {
        filename: 'main.js',
        path: path.resolve(__dirname, './public'),
        publicPath: "./"
    },
    devtool: "source-map",
    module: {
        rules: [{
                test: /\.md$/,
                use: [
                    {
                        loader: "html-loader"
                    },
                    'babel-loader',
                    {
                        loader: "markdown-component-loader"
                    }
                ]
            }]
    },
    
}

module.exports = config