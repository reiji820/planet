const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

// jQueryをWebpack環境に提供する設定
environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default']
}))

module.exports = environment
