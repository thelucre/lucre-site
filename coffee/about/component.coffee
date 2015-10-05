Vue = require 'vue'
require 'transitions.scss'

# Define some components
AboutPage = Vue.extend

  template: require('./template.html')

  data: () ->
    data = {}
    return data

  attached: () ->
    console.log 'in about page'
    return

  methods:
    test: () =>
      return

module.exports = AboutPage
