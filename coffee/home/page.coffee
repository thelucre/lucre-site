# Dependencies
$ = require "jquery"
_ = require "lodash"
Backbone = require "backbone"
Marquee = require '../3d/marquee.coffee'
Detector = require 'detector'
$.velocity = require 'velocity'

require 'home.scss'
require 'transitions.scss'

# Init view
HomePage =
  initialize: (options) ->
    _.bindAll @

    if Detector.webgl
      window.marquee = new Marquee()

      _.each $('.menu a'), (link, i ) ->
        $(link).velocity(
          { scaleY: [1,0], opacity: [1,0] },
          { duration: 1000, delay: 100 + i * 300, easing: 'spring', delay: 6800 + i * 300 }
        )
        return
    else
      console.log 'SHOW THE NORMAL HTML VIEW'



    return

module.exports = Backbone.View.extend HomePage
