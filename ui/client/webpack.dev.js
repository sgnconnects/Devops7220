const merge = require('webpack-merge');
const config = require('./webpack.config.js');
const path = require('path');

const PUBLIC_DIR = path.resolve(__dirname, 'public');

dev_config = merge(config, {
    mode: 'development',
    devServer: {
        contentBase: PUBLIC_DIR,
        compress: false,
        port: 3000
    }
});

module.exports = dev_config;