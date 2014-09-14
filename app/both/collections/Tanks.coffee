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

  msg: (txt) ->
    $("#msg").text(txt)
  
  doBoost: (vel) ->
    curAngle = @angle or Math.PI / 2 # default to rotation 0
    console.log("angle ", @angle)

    deltaX = Math.sin(curAngle)
    deltaY = Math.cos(curAngle)

    t = @top + (deltaX * BOOST_SPEED)
    l = @left + (deltaY * BOOST_SPEED)

    @setProps(top: t)
    @setProps(left: l)

    @msg("top #{@top}")
    @msg("left #{@left}")

  doRotate: (deltaRad) ->
    @angle ?= Math.PI / 2
    angle = @angle + deltaRad

    rotate = angle
    console.log("delta ", deltaRad)
    console.log("cur angle ", angle)
    console.log("cur rotate ", rotate)
    @setProps(rotate: rotate)
    @setProps(angle: angle)
    @msg("rotate #{@rotate}")

  doShoot: (vec) ->
    # tell Battle to handle the bullet
    
    @msg("shoot #{vec}")




