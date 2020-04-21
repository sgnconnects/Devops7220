const merge = require('webpack-merge');
const config = require('./webpack.config.js');
const path = require('path');

const PUBLIC_DIR = path.resolve(__dirname, 'public');

prod_config = merge(config, {
    mode: 'production',
    devServer: {
        contentBase: PUBLIC_DIR,
        host: '0.0.0.0',
        compress: true,
        disableHostCheck: true,
        // proxy: {
        //     "/coins": {
        //         target: process.env.REACT_APP_API_HOST,
        //         logLevel: 'debug'
        //     }
        // },
        port: 3000
    }
});


module.exports = prod_config;