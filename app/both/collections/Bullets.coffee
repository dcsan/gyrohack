@Bullets = new Meteor.Collection('Bullets')

if Meteor.isServer
  Meteor.publish "Bullets", (query) ->
    console.log("sub.Bullets", query)
    curs = Bullets.find(query)
    return curs

  Bullets.allow
    insert: () ->
      return true
    update: () ->
      return true
    remove: () ->
      return true

  sayHello = ->
    console.log("Hello from timmer")
    return

  zeitInterval = Meteor.setInterval(sayHello, 1000)


Bullets.helpers
  setProps: (props) ->
    Bullets.update(
      @_id,
      $set: props
    )
    _.extend(@, props)

  msg: (txt) ->
    $("#msg").text(txt)
  
  # bullets should be set as an interval
  doFly: (vel) ->
    curAngle = @angle or Math.PI / 2 # default to rotation 0
    console.log("bullet angle ", @angle)

    deltaX = Math.sin(curAngle)
    deltaY = Math.cos(curAngle)

    t = @top + (deltaX * vel)
    l = @left + (deltaY * vel)

    @setProps(top: t)
    @setProps(left: l)

    @msg("top #{@top}")
    @msg("left #{@left}")

