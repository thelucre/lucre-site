bower_dir = __dirname + '/js/vendor'

webpack = require 'webpack'
ExtractTextPlugin = require 'extract-text-webpack-plugin'

module.exports =

  entry: __dirname + '/coffee/start.coffee'

  output:
    path: __dirname + '/build'
    publicPath: '/build/'
    filename: 'build.js'

  devtool: 'source-map'

  module: loaders: [
    {
      # Exposes jQuery and $ to the window object. This does not automatically load the jquery module.
      test: /jquery\.js$/
      loader: "expose?jQuery!expose?$"
    }
    {
      test: /\.html$/
      loader: 'html'
    }
    {
      test: /\.scss$/
      loader: ExtractTextPlugin.extract 'style-loader', 'css?sourceMap!sass?sourceMap'
    }
    {
      test: /\.(png|woff|woff2|eot|ttf|svg)($|\?)/
      loader: 'url-loader?limit=100000'
    }
    {
      test: /\.coffee$/
      loader: "coffee-loader"
    }
  ]

  resolve:
    modulesDirectories: [
      'sass'
    ]

    alias:
      'jquery': bower_dir + '/jquery/dist/jquery.js'
      'backbone': bower_dir + '/backbone/backbone-min.js'
      'lodash': bower_dir + '/lodash/lodash.js'
      'underscore': bower_dir + '/lodash/lodash.js'
      'text': bower_dir + '/requirejs-text/text.js'
      'vue': bower_dir + '/vue/dist/vue.js'
      'vue-router': bower_dir + '/vue-router/dist/vue-router.js'
      'threejs': bower_dir + '/three.js/three.js'
      'detector': bower_dir + '/../utils/detector.js'
      'tweenjs': bower_dir + '/tweenjs/src/Tween.js'
      'domevents': bower_dir + '/../utils/threex.domevents.js'
      'linkify': bower_dir + '/../utils/threex.linkify.js'
      'velocity': bower_dir + '/velocity/velocity.min.js'

  plugins: [
    new webpack.OldWatchingPlugin,
    new webpack.ProvidePlugin
      _: 'lodash'
      $: "jquery"
      jQuery: "jquery"
      "window.jQuery": "jquery"
      "root.jQuery": "jquery",
    new ExtractTextPlugin 'style.css', { allChunks: true }
  ]
