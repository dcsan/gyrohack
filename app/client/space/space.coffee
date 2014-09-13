deviceMotionHandler = (eventData) ->
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
  
  # // Grab the refresh interval from the results
  info = eventData.interval
  document.getElementById("moInterval").innerHTML = info
  return

Template.space.rendered = ->
  console.log("attaching events")
  window.addEventListener('devicemotion', deviceMotionHandler, false);
