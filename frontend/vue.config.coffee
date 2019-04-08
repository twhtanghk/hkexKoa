{EnvironmentPlugin} = require 'webpack'
CompressionWebpackPlugin = require 'compression-webpack-plugin'

{URL} = require 'url'
{HKEXNew} = require 'hkex'
url = new URL HKEXNew.$urlRoot.ch
url.pathname = ''
process.env.HKEX_URL = url.toString()

module.exports =
  publicPath: './'
  outputDir: '../backend/dist'
  lintOnSave: false
  devServer:
    host: '0.0.0.0'
    disableHostCheck: true
  configureWebpack: (config) ->
    if process.env.NODE_ENV == 'production'
      config.plugins.push new CompressionWebpackPlugin
        deleteOriginalAssets: true
        include: [
          /\.ico$/
          /\.html$/
          /\.js$/
          /\.css$/
          /\.map$/
        ]
      process.env.API_URL = '.'
    config.node.url = true
    config.plugins.push new EnvironmentPlugin [
      'API_URL'
      'HKEX_URL'
    ]
    config.module.rules.push
      test: /\.coffee$/
      use: ['babel-loader', 'coffee-loader']
    return
