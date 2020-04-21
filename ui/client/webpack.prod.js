const merge = require('webpack-merge');
const config = require('./webpack.config.js');
const path = require('path');

const PUBLIC_DIR = path.resolve(__dirname, 'public');

prod_config = merge(config, {
    mode: 'production',
    devServer: {
        contentBase: PUBLIC_DIR,
        compress: true,
        port: 3000
    }
});


module.exports = prod_config;