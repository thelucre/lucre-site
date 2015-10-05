
# VIEW TEMPLATE 

define (require) ->

	# Dependencies
	$ = require "jquery"
	_ = require "lodash"
	Backbone = require "backbone"

	# Init view
	View = {}

	View.initialize = (options) ->
		_.bindAll this

		console.log 'test'

		return

	Backbone.View.extend View