# Dependencies
$ = require "jquery"
_ = require 'lodash'

require 'style.scss'
require 'transitions.scss'

window.theme_path = '/wp-content/themes/new-lucre/';
HomePage = require './home/page.coffee'

$(document).ready () ->

  home = new HomePage({ el: '#app' });
