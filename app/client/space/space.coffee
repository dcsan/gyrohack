lastEventTime = (new Date()).getTime()

player = null

initGame = (data) ->
  player = Players.findOne({name:data.playerName})
  window.player = player

resizeHandler = (evt) ->
  console.log("resizeHandler", evt)

deviceMotionHandler = (eventData) ->
  return unless player

  curEventTime = (new Date()).getTime()
  return if (curEventTime - lastEventTime) < 500

  lastEventTime = curEventTime
  # console.log("curTime", curEventTime)
  
  # console.log("deviceMotionHandler", eventData)
  info = undefined
  xyz = "[X, Y, Z]"

  # Grab the acceleration from the results
  acceleration = eventData.acceleration
  info = xyz.replace("X", acceleration.x)
  info = info.replace("Y", acceleration.y)
  info = info.replace("Z", acceleration.z)
  document.getElementById("moAccel").innerHTML = info
  
  # Grab the acceleration including gravity from the results
  acceleration = eventData.accelerationIncludingGravity
  info = xyz.replace("X", acceleration.x)
  info = info.replace("Y", acceleration.y)
  info = info.replace("Z", acceleration.z)
  document.getElementById("moAccelGrav").innerHTML = info
  
  # Grab the rotation rate from the results
  rotation = eventData.rotationRate
  info = xyz.replace("X", rotation.alpha)
  info = info.replace("Y", rotation.beta)
  info = info.replace("Z", rotation.gamma)
  document.getElementById("moRotation").innerHTML = info

  # console.log(eventData.interval)

  Players.update(
    player._id,
    $set: {
      eventData: eventData
    }
  )

  room = Rooms.findOne({room_name: "the room"})

  Rooms.update(
    room._id,
    $set: {
      status: "trigger a change event" 
    }
  )
  
  return

Template.space.rendered = (obj) ->
  # data = obj.data
  console.log("rendered", obj, this)
  console.log("data", this.data)
  initGame(this.data)
  enterRoom()

moveEvent = null

enterRoom = (room) ->
  console.log("enterRoom", room)
  $(window).on 'resize', (e) -> resizeHandler
  window.addEventListener('devicemotion', deviceMotionHandler, false)

  # find "the room" and join (only one room for now)
  room = Rooms.findOne({name: "the room"})
  window.room = room # debug

  player_names = room.player_names or []
  player_names.push player.name

  Rooms.update(
    room._id,
    $set: {
      player_names: player_names
    }
  )

  # $(window).on 'devicemotion', (e) -> deviceMotionHandler
  # window.addEventListener "deviceorientation", ( (event) ->
  #   deviceMotionHandler(event)
  # ), false


# window events have to be removed manually when leaving page
Template.space.exitRoom = (room) ->
  console.log('player exitRoom', room)
  window.removeEventListener('devicemotion', deviceMotionHandler, false)

  # $(window).off 'devicemotion'

  room = Rooms.findOne({name: "the room"})

  player_names = room.player_names or []

  index_to_remove = player_names.indexOf(player.name)
  player_names.splice(index_to_remove, 1)

  Rooms.update(
    room._id,
    $set: {
      player_names: player_names
    }
  )
