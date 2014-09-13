lastEventTime = (new Date()).getTime()

player = null

initGame = () ->
  player = Players.findOne({name:'A'})
  window.player = player

resizeHandler = (evt) ->
  console.log("resizeHandler", evt)

deviceMotionHandler = (eventData) ->
  curEventTime = (new Date()).getTime()
  if (curEventTime - lastEventTime) < 500
    return

  lastEventTime = curEventTime
  console.log("curTime", curEventTime)
  
  console.log("deviceMotionHandler", eventData)
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

  console.log(eventData.interval)

  Players.update(
    player._id,
    $set: {
      eventData: eventData
    }
  )

  lg = LineGraphs.findOne({"player_name": "A"})
  data = lg.data or []
  sample = eventData.acceleration.x
  data.push(sample)

  LineGraphs.update(
    lg._id,
    $set: {
      data: data
    }
  )
  
  return

Template.space.rendered = ->
  initGame()
  enterRoom()

moveEvent = null

enterRoom = (room) ->
  console.log("enterRoom", room)
  $(window).on 'resize', (e) -> resizeHandler
  # $(window).on 'devicemotion', (e) -> deviceMotionHandler
  window.addEventListener('devicemotion', deviceMotionHandler, false)
  # window.addEventListener "deviceorientation", ( (event) ->
  #   deviceMotionHandler(event)
  # ), false


# window events have to be removed manually when leaving page
Template.space.exitRoom = (room) ->
  console.log('exitRoom', room)
  window.removeEventListener('devicemotion', deviceMotionHandler, false);

  # $(window).off 'devicemotion'


