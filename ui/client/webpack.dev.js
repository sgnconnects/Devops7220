const merge = require('webpack-merge');
const config = require('./webpack.config.js');
const path = require('path');

const PUBLIC_DIR = path.resolve(__dirname, 'public');

dev_config = merge(config, {
    mode: 'development',
    devServer: {
        contentBase: PUBLIC_DIR,
        host: '0.0.0.0',
        disableHostCheck: true,
        // proxy: {
        //     "/coins": {
        //         target: process.env.REACT_APP_API_HOST,
        //         logLevel: 'debug'
        //     }
        // },
        compress: false,
        port: 3000
    }
});

module.exports = dev_config;