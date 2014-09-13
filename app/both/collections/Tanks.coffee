@Tanks = new Meteor.Collection('Tanks')

BOOST_SPEED = 10
ROTATE_SPEED = 10

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
    t = @top + (vel * BOOST_SPEED)
    @setProps(top: t)
    @msg("top #{@top}")

  doRotate: (deg) ->
    v = @rotate + (deg * ROTATE_SPEED)
    @setProps(rotate: v)
    @msg("rotate #{@rotate}")

  doShoot: (vec) ->
    @msg("shoot #{vec}")
