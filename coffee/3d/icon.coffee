
# Dependencies
$ = require 'jquery'
_ = require 'lodash'
THREE = require 'threejs'
TWEEN = require 'tweenjs'
THREEx = {}
THREEx.Linkify = require 'linkify'

class Icon

  constructor: (options) ->

    # pull options
    {
      @scene
      @stagger
      @domEvents
      @url
      @animateFrom
      @position
      @animateTo
    } = options

    # object values
    @src = window.theme_path + 'models/' + options.file + '.json'

    @material = new THREE.MeshLambertMaterial
      color: 0xFFFFFF
      side: THREE.DoubleSide
      shading: THREE.FlatShading
      transparent: true
      # lights: true

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
    @object.rotation.set @animateFrom.rx, @animateFrom.ry, @animateFrom.rz
    @object.position.set @position.x, @position.y, @position.z
    @object.scale.set 0
    @scene.add @object
    @tween = new TWEEN.Tween()

    light = new THREE.SpotLight 0xffffff
    light.position.set @position.x, @position.y, @position.z + 2
    light.target = @object
    @scene.add light

    @loaded = true
    self = this
    intro = new TWEEN.Tween({ scale: 0, rx: 0, ry: 0, rz: Math.PI / 2, opacity: 0 })
      .to _.assign(_.clone(@animateFrom), { opacity: 1 }), 1450
      .onUpdate () ->
        self.object.scale.set @scale, @scale, @scale
        self.object.rotation.set @rx, @ry, @rz
        self.material.opacity = @opacity
        return
      .onComplete () ->
        self.ready()
        return
      .delay 5400 + Math.random() * 1000
      .easing TWEEN.Easing.Back.Out
      .start()
    return


    return

  update: =>
    return unless @loaded

    return

  ready: () =>
    if @domEvents?
      @domEvents.addEventListener @object, 'click', (me) ->
        console.log me
        return

      @domEvents.addEventListener @object, 'mouseover', @onHover, true
      @domEvents.addEventListener @object, 'mouseout', @onHoverExit
      @domEvents.addEventListener @object, 'touchstart', @onHover
      @domEvents.addEventListener @object, 'touchend', @onHoverExit
      @link = THREEx.Linkify @domEvents, @object, @url, false
    return

  onHover: () =>
    object = @object

    @tween.stop()
    @tween = new TWEEN.Tween({ scale: object.scale.x, rx: object.rotation.x, ry: object.rotation.y, rz: object.rotation.z })
      .to _.clone(@animateTo), 450
      .onUpdate () ->
        object.scale.set @scale, @scale, @scale
        object.rotation.set @rx, @ry, @rz
        return
      .easing TWEEN.Easing.Back.InOut
      .start()

    return

  onHoverExit: () =>
    object = @object
    @tween.stop()
    @tween = new TWEEN.Tween({ scale: object.scale.x, rx: object.rotation.x, ry: object.rotation.y, rz: object.rotation.z })
      .to _.clone(@animateFrom), 450
      .onUpdate () ->
        object.scale.set @scale, @scale, @scale
        object.rotation.set @rx, @ry, @rz
        return
      .easing TWEEN.Easing.Back.InOut
      .start()
    return

module.exports = Icon
