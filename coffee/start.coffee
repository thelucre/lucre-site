# Dependencies
$ = require "jquery"
_ = require 'lodash'

require 'style.scss'
require 'transitions.scss'

window.theme_path = '/wordpress/wp-content/themes/new-lucre/';
HomePage = require './home/page.coffee'

$(document).ready () ->

  if $('body').hasClass 'home'
    home = new HomePage({ el: '#app' });
