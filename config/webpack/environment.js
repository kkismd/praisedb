const { environment } = require('@rails/webpacker')
const elm = require('./loaders/elm')

environment.loaders.prepend('elm', elm)

const webpack = require('webpack');
environment.plugins.append('Provide', new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    'window.jQuery': 'jquery',
    Popper: ['popper.js', 'default']
}));

module.exports = environment
