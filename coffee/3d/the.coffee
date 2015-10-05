_ = require 'lodash'
THREE = require 'threejs'
TWEEN = require 'tweenjs'

class The
  constructor: (@scene) ->
    @lines = []
    @group = new THREE.Group()

    w = 0.003
    v = 0.12
    h = 0.1

    config = [
      #  T
      { px:-0.2 , py:1 , pz:0, lx: h , ly: w , lz:0.001 }
      { px:-0.2 , py:1 - v/2 , pz:0, lx: w , ly: v , lz:0 }

      #  H
      { px:-0.04 + h*.05, py:1 - v/2 , pz:0, lx: w , ly: v , lz:0 }
      { px:0.01 , py:1 - v/2, pz:0, lx: h*0.9 , ly:w , lz:0 }
      { px:-0.04 + h*0.95 , py:1 - v/2 , pz:0, lx: w , ly: v , lz:0 }

      # E
      { px:.2 , py:1 - v/2 , pz:0, lx:w , ly:v , lz:0 }
      { px:.2 + h/2 - h*0.1, py:1 , pz:0, lx:h *0.8, ly:w , lz:0 }
      { px:.2 + h/2 - h*0.15, py:1  - v/2, pz:0, lx:h *0.7 , ly:w , lz:0 }
      { px:.2 + h/2 - h*0.1, py:1 - v, pz:0, lx:h *0.8 , ly:w , lz:0 }
    ]

    _.each config, (line) =>
      geometry = new THREE.CubeGeometry line.lx, line.ly, line.lz
      material = new THREE.MeshBasicMaterial { color: 0xffffff, side: THREE.DoubleSide, transparent: true, opacity: 0 }
      cube = new THREE.Mesh geometry, material
      # cube.rotation.set line.rx, line.ry, line.rz
      cube.position.set line.px, line.py, line.pz
      @group.add( cube );
      @lines.push cube
      return

    @group.position.set 0,0,-1
    @scene.add @group

    _.each @lines, (line, i) ->
      tweenA = new TWEEN.Tween({ a: 0 })
        .to { a: 0.8 }, 1000
        .onUpdate () ->
          line.material.opacity = @a
          return
        .easing TWEEN.Easing.Quadratic.InOut
        .delay 300 + i * 200
        .start()
      return

    _.each @lines, (line, i) ->
      tweenB = new TWEEN.Tween({ rx: -1 + 2*Math.random() , ry: -1 + 2*Math.random(), rz: -1 + 2*Math.random() })
        .to { rx: 0, ry: 0, rz: 0 }, 1600
        .onUpdate () ->
          line.rotation.set @rx, @ry, @rz
          return
        .easing TWEEN.Easing.Quadratic.InOut
        .delay 300 + i * 200
        .start()
      return

    group = @group
    tweenS = new TWEEN.Tween { s: 0.0 }
      .to { s: 1 }, 3500
      .onUpdate () ->
        group.scale.set @s,@s,@s
      .easing TWEEN.Easing.Circular.Out
      .start()

    return

  render: () =>

    return

  update: () =>

    return

module.exports = The;
