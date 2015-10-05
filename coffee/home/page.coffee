# Dependencies
$ = require "jquery"
_ = require "lodash"
Backbone = require "backbone"
Marquee = require '../3d/marquee.coffee'
Detector = require 'detector'
$.velocity = require 'velocity'

require 'style.scss'
require 'home.scss'
require 'transitions.scss'

# Init view
HomePage =
  initialize: (options) ->
    _.bindAll @

    if Detector.webgl
      $('.polyfield').remove();
      $('.home-mobile').remove();

      window.marquee = new Marquee()

      _.each $('.menu a'), (link, i ) ->
        $(link).velocity(
          { scaleY: [1,0], opacity: [1,0] },
          { duration: 1000, delay: 100 + i * 300, easing: 'spring', delay: 6800 + i * 300 }
        )
        return
    else
      @runStaticPage()

    return

  runStaticPage: () =>
    $('#app').height( $(window).outerHeight());

    $('.polyfield').css('display', 'block');
    $('.home-mobile').css('display', 'block');

    $('.the').velocity({ translateY: ['0', '50%'], opacity: [0.8, 0] },{ duration : 1000, easing: 'easeOutQuad', delay: 300 });

    $('.logo').velocity({ translateY: ['0', '5%'], opacity: [0.8, 0] },{ duration : 1000, easing: 'easeInOutQuad', delay: 900, display: 'block' });

    _.each $('.menu a, .social a'), (link, i ) ->
      $(link).velocity(
        { scaleY: [1,0], opacity: [1,0] },
        { duration: 1000, delay: 1700 + i * 300, easing: 'spring' }
      )
      return

    $('.polyfield').css( 'background-image', 'url(' + $('.polyfield').data('image') + ')');

    # REsize app area for home marquee
    $(window).on('resize', () ->
      $('#app').height( $(window).outerHeight());
      return
    )
    return

module.exports = Backbone.View.extend HomePage
