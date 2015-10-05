# Dependencies
$ = require 'jquery'
_ = require 'lodash'
THREE = require 'threejs'
Letter = require './letter.coffee'
The = require './the.coffee'
Polyfield = require './polyfield.coffee'
TWEEN = require 'tweenjs'
THREEx = require 'domevents'
Icon = require './icon.coffee'

class Marquee

  constructor: () ->
    @stats = undefined
    @scene = undefined
    @renderer = undefined
    @composer = undefined
    @camera = undefined
    @cameraControls = undefined

    @mouseX = 0
    @mouseY = 0
    @frame = 0;

    @letters = []

    # Selectors
    @$win = $(window)

    @renderer = new (THREE.WebGLRenderer)(
      antialias: true
      preserveDrawingBuffer: true
      alpha: true)
    @renderer.setClearColor 0xbbbbbb

    @renderer.setSize window.innerWidth, window.innerHeight
    @renderer.setClearColor 0x000000, 0
    # the default
    document.getElementById('container').appendChild @renderer.domElement
    # create a @scene
    @scene = new (THREE.Scene)
    # put a @camera in the @scene
    @camera = new (THREE.PerspectiveCamera)(35, window.innerWidth / window.innerHeight, 1, 10000)
    @camera.position.set 0, 0, 5
    @scene.add @camera

    # here you add your objects
    # - you will most likely replace this part by your own
    ambientColor = (Math.random() * 0xffffff)
    light = new THREE.AmbientLight ambientColor
    @scene.add light

    dlight1 = new (THREE.DirectionalLight)(Math.random() * 0xffffff)
    dlight1.position.set(Math.random(), Math.random(), Math.random()).normalize()
    @scene.add dlight1
    dirLightHelper1 = new THREE.DirectionalLightHelper( dlight1, 0.2 );
    # @scene.add( dirLightHelper1 );

    dlight2 = new (THREE.DirectionalLight)(Math.random() * 0xffffff)
    dlight2.position.set(Math.random(), Math.random(), Math.random()).normalize()
    @scene.add dlight2
    dirLightHelper2 = new THREE.DirectionalLightHelper( dlight2, 0.2 );
    # @scene.add( dirLightHelper2 );

    light = new (THREE.PointLight)(Math.random() * 0xffffff)
    light.position.set(Math.random() - 0.5, Math.random() - 0.5, Math.random() - 0.5).normalize().multiplyScalar 1.2
    @scene.add light
    pointLightHelper1 = new THREE.PointLightHelper( light, 0.2 );
    # @scene.add( pointLightHelper1 );

    light2 = new (THREE.PointLight)(Math.random() * 0xffffff)
    light2.position.set(Math.random() - 0.5, Math.random() - 0.5, Math.random() - 0.5).normalize().multiplyScalar 1.2
    @scene.add light2
    pointLightHelper2 = new THREE.PointLightHelper( light2, 0.2 );
    # @scene.add( pointLightHelper2 );

    @letters.push new Letter
      letter: 'L'
      scene: @scene
      stagger: 200
      domEvents: @domEvents

    @letters.push new Letter
      letter: 'U'
      scene: @scene
      stagger: 200

    @letters.push new Letter
      letter: 'C'
      scene: @scene
      stagger: 600

    @letters.push new Letter
      letter: 'R'
      scene: @scene
      stagger: 800

    @letters.push new Letter
      letter: 'E'
      scene: @scene
      stagger: 1200


    @scene2 = new (THREE.Scene)
    # put a @camera in the @scene2
    @camera2 = new (THREE.PerspectiveCamera)(35, window.innerWidth / window.innerHeight, 1, 10000)
    @camera2.position.set 0, 0, 5
    @scene2.add @camera2
    @domEvents = new THREEx.DomEvents @camera2, @renderer.domElement

    light = new THREE.AmbientLight ambientColor
    @scene2.add light

    @twitter = new Icon
      scene: @scene2
      domEvents: @domEvents
      file: 'twitter'
      url: 'http://www.twitter.com/thelucre'
      animateFrom:
        scale: 5
        rx: Math.PI / 2.2
        ry: -0.1
        rz: -0.1
      animateTo:
        scale: 6.2
        rx: Math.PI / 1.8
        ry: 0
        rz: 0.1
      position:
        x: -0.43
        y: -0.55
        z: 0

    @instagram = new Icon
      scene: @scene2
      domEvents: @domEvents
      file: 'instagram'
      url: 'http://www.instagram.com/thelucre'
      animateFrom:
        scale: 5.6
        rx: Math.PI / 2.2
        ry: 0.001
        rz: 0.06
      animateTo:
        scale: 6.5
        rx: Math.PI / 2.5
        ry: -0.1
        rz: 0.2
      position:
        x: -0.07
        y: -0.49
        z: 0

    @mail = new Icon
      scene: @scene2
      domEvents: @domEvents
      file: 'mail'
      url: 'mailto:howard.eric.m@gmail.com'
      animateFrom:
        scale: 1.7
        rx: Math.PI / 2.2
        ry: 0.001
        rz: 0.06
      animateTo:
        scale: 2.1
        rx: Math.PI / 2.5
        ry: 0.1
        rz: 0.3
      position:
        x: 0.47
        y: -0.575
        z: 0

    @the = new The @scene

    @polyfield = new Polyfield @scene

    @animate(0)

    @$win.on 'resize', @onWindowResize
    @$win.on 'mousemove mouseover', @onMouseMove

    @renderer.autoClear = false

    return

  animate: (time) =>
    # loop on request animation loop
    # - it has to be at the begining of the function
    # - see details at http://my.opera.com/emoller/blog/2011/12/20/requestanimationframe-for-smart-er-animating
    requestAnimationFrame @animate

    # @camera.position.x += ( @mouseX/8 - @camera.position.x ) * .001
    # @camera.position.x = THREE.Math.clamp( @camera.position.x, -2, 2 )
    # @camera.position.y += ( @mouseY/8 - @camera.position.y ) * .001
    # @camera.position.y = THREE.Math.clamp( @camera.position.y, -2, 2 )

    @camera.lookAt( @scene.position );
    @camera2.lookAt( @scene2.position );

    TWEEN.update(time);

    _.each @letters, (letter) =>
      letter.update()

    if @polyfield?
      @polyfield.update @frame

    # do the render
    @render()
    @frame++
    return

  # render the scene

  render: =>
    @renderer.clear();

    @renderer.render @scene2, @camera2
    @renderer.render @scene, @camera

    return

  ###*
   * Maintain canvas size the width of the screen
  ###
  onWindowResize: () =>
    @camera.aspect = @$win.innerWidth() / @$win.innerHeight()
    @camera.updateProjectionMatrix()
    @camera2.aspect = @$win.innerWidth() / @$win.innerHeight()
    @camera2.updateProjectionMatrix()
    @renderer.setSize @$win.innerWidth(), @$win.innerHeight()

    if( @$win.outerWidth() < 500 )
      @camera.position.set( 0, 0, 15)
      @camera2.position.set( 0, 0, 15)
    else if( @$win.outerWidth() < 768 )
      @camera.position.set( 0, 0, 10)
      @camera2.position.set( 0, 0, 10)
    else
      @camera.position.set( 0, 0, 5)
      @camera2.position.set( 0, 0, 5)

    return

  onMouseMove: ( e ) =>
    windowHalfX = @$win.innerWidth() / 2
    windowHalfY = @$win.innerHeight() / 2

    @mouseX = ( e.clientX - windowHalfX ) / 2
    @mouseY = ( e.clientY - windowHalfY ) / 2
    return


module.exports = Marquee
