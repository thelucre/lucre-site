
# Dependencies
$ = require 'jquery'
_ = require 'lodash'
THREE = require 'threejs'
TWEEN = require 'tweenjs'

class Letter

  constructor: (options) ->

    # pull options
    @scene = options.scene
    @stagger = options.stagger
    @domEvents = options.domEvents

    @originalGeometry
    @messFactor = 0
    # object values
    @src = window.theme_path + 'models/' + options.letter + '.json'

    @props = { x: Math.PI / 4, y: 0, z: 0, a: 0, px : -1.2, py: -0.5, pz: -3 }

    @material = new (THREE.MeshPhongMaterial)(
      wireframe: false
      shading: THREE.FlatShading)
    # load the JSON mesh object
    @load()
    return

  load: =>
    # load a JSON mesh
    # instantiate a loader
    loader = new (THREE.JSONLoader)
    # load a resource
    loader.load @src, @onLoad
    return

  onLoad: (geometry, materials) =>
    # Function when resource is loaded
    @originalGeometry = geometry.clone()
    @geometry = geometry
    @object = new (THREE.Mesh)(@geometry, @material)
    @object.position.set @props.px, @props.py, @props.pz
    @object.rotation.set @props.x, @props.y, @props.z
    @object.scale.set 3, 3, 3
    @scene.add @object
    @object.material.transparent = true
    @object.material.opacity = 0 #@props.a
    @loaded = true

    object = @object
    tweenPos = new TWEEN.Tween( @props )
      .to { x: Math.PI / 2, y: 0, z: .05 }, 2000
      .onUpdate () ->
        object.rotation.set @x, @y, @z
        return
      .easing TWEEN.Easing.Quadratic.Out
      .delay 2400 + @stagger * 1.5
      # .repeat(Infinity)
      .start()

    tweenA = new TWEEN.Tween( @props )
      .to { px: -1.37, py: -0.5, pz: -1 }, 2000
      .onUpdate () ->
        object.position.set @px, @py, @pz
        return
      .easing TWEEN.Easing.Circular.Out
      .delay 2400 + @stagger * 1.5
      .start()

    tweenA = new TWEEN.Tween( @props )
      .to { a: 1 }, 2200
      .onUpdate () ->
        object.material.opacity = @.a
        return
      .easing TWEEN.Easing.Quadratic.InOut
      .delay 2400 + @stagger * 1.5
      .start()

    if @domEvents?
      @domEvents.addEventListener @object, 'click', (me) ->
        console.log me
        return

    return

  update: =>
    return unless @loaded

    return

module.exports = Letter
