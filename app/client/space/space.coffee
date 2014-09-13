lastEventTime = 0

player = null

initGame = () ->
  player = Players.findOne({name:'A'})
  window.player = player

deviceMotionHandler = (eventData) ->
  info = undefined
  xyz = "[X, Y, Z]"

  sampleTime = eventData.interval
  console.log("sampleTime", sampleTime)
  # // Grab the refresh interval from the results
  document.getElementById("moInterval").innerHTML = sampleTime
  
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

  Players.update(
    player._id,
    $set: {
      eventData: eventData
    }
  )

  lg = LineGraphs.findOne({"player_name": "A"})

  LineGraphs.update(
    lg._id,
    $set: {
      data: new_data
    }
  )
  
  return

Template.space.rendered = ->
  console.log("attaching events")
  initGame()
  window.addEventListener('devicemotion', deviceMotionHandler, false)
