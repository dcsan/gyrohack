@Tanks = new Meteor.Collection('Tanks')

BOOST_SPEED = 1
ROTATE_SPEED = 1

if Meteor.isServer
  Meteor.publish "Tanks", (query) ->
    console.log("sub.Tanks", query)
    curs = Tanks.find(query)
    return curs

  Tanks.allow
    insert: () ->
      return true
    update: () ->
      return true
    remove: () ->
      return true

Tanks.helpers

  setProps: (props) ->
    Tanks.update(
      @_id,
      $set: props
    )
    _.extend(@, props)
    # console.log('player.setProps', props, @)

  joinRoom: (battle) ->
    @setProps({
      battleId: battle.battleId
    })

  msg: (txt) ->
    $("#msg").text(txt)
  
  doBoost: (vel) ->
    curAngle = @angle or Math.PI / 2 # default to rotation 0
    console.log("angle ", @angle)

    deltaX = Math.sin(curAngle)
    deltaY = Math.cos(curAngle)

    t = @top + (deltaX * vel)
    l = @left + (deltaY * vel)

    @setProps(top: t)
    @setProps(left: l)

    @msg("top #{@top}")
    @msg("left #{@left}")

  doRotate: (deltaRad) ->
    @angle ?= Math.PI / 2
    angle = @angle + deltaRad

    #if angle < 0.5 * Math.PI
    #  rotate = 0.5 * Math.PI - angle
    #else if angle < 1.5 * Math.PI
    #  rotate = angle - 0.5 * Math.PI
    #else if angle < 2 * PI

    rotate = angle + Math.PI / 2
    console.log("delta ", deltaRad)
    console.log("cur angle ", angle)
    console.log("cur rotate ", rotate)
    @setProps({rotate: rotate})
    @setProps({angle: angle})
    @msg("rotate #{@rotate}")

  doShoot: (vec, battle) ->
    # tell Battle to handle the bullet
    @msg("shoot #{vec}")


Tanks.reset = () ->
  console.log("Tanks.reset")
  Tanks.remove({})
  names = ["red", "blue", "green", "yellow" ]
  idx = 1
  _.each names, (name) ->
    tank = {
      idx: idx++
      name: name
    }
    Tanks.insert tank


