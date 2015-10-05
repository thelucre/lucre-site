_ = require 'lodash'
THREE = require 'threejs'
TWEEN = require 'tweenjs'
Vert = require 'raw!./shaders/displacement.vert'
Frag = require 'raw!./shaders/displacement.frag'

class Polyfield
  constructor: (@scene) ->
    @geometry = new THREE.PlaneGeometry( 40, 20, 30, 30 );

    # @material = new THREE.MeshBasicMaterial
    #   color: 0xffffff
    #   side: THREE.DoubleSide
    #   transparent: true
    #   opacity: 0.1
    #   wireframe: true
    #   shading: THREE.FlatShading

    @attributes = {}

    @uniforms = THREE.UniformsUtils.merge([
      THREE.UniformsLib['lights'], { delta: {type: 'f', value: 0.0}, scale: {type: 'f', value: 1.0}, alpha: {type: 'f', value: 0.0} }
    ])

    @material = new THREE.ShaderMaterial
      attributes: @attributes
      uniforms: @uniforms
      vertexShader: Vert
      fragmentShader: Frag
      transparent: true
      lights: true
      side: THREE.DoubleSide
      wireframe: true

    @plane = new THREE.Mesh( @geometry, @material );

    @plane.position.set 0, 0, -10
    @scene.add( @plane );

    #  LIGHT Orbits the cube
    @light	= new THREE.SpotLight( 0xFFFFFF );
    @light.position.set(0,0,-75);
    @light.intensity = 105
    @scene.add( @light );

    #  light follows the cube
    @light.target = @plane

    alpha = @uniforms.alpha
    tweenA = new TWEEN.Tween({ a: 0 })
      .to { a: 0.023 }, 1000
      .onUpdate () ->
        alpha.value = @a
        return
      .easing TWEEN.Easing.Quadratic.In
      .delay 5500
      .start()
    return

    return

  render: () =>
    return

  update: (frame) =>
    # @uniforms.amplitude.value = Math.sin frame * 0.01;
    @uniforms.delta.value = frame / 500
    # @uniforms.alpha.value = 0.019
    return

module.exports = Polyfield
