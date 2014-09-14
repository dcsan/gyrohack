lastEventTime = (new Date()).getTime()
tank = null
@TankInit = {
  hasRun: false
}
@gamma_buffer = []


resizeHandler = (evt) ->
  console.log("resizeHandler", evt)

deviceMotionHandler = (eventData) ->
  return unless tank
  @gamma_buffer.push eventData.rotationRate.gamma

  curEventTime = (new Date()).getTime()
  return if (curEventTime - lastEventTime) < 100

  lastEventTime = curEventTime
  console.log("pilot updated at, curTime", curEventTime)

  sum = 0
  for item in @gamma_buffer
      sum += item

  ave = sum / @gamma_buffer.length
  @gamma_buffer = []

  document.getElementById("debug").innerHTML = ave
  
  info = undefined
  xyz = "[X, Y, Z]"

  # Grab the acceleration from the results
  acceleration = eventData.acceleration
  info = xyz.replace("X", acceleration.x.toFixed(4))
  info = info.replace("Y", acceleration.y.toFixed(4))
  info = info.replace("Z", acceleration.z.toFixed(4))
  document.getElementById("moAccel").innerHTML = info
  
  # Grab the acceleration including gravity from the results
  acceleration = eventData.accelerationIncludingGravity
  info = xyz.replace("X", acceleration.x.toFixed(4))
  info = info.replace("Y", acceleration.y.toFixed(4))
  info = info.replace("Z", acceleration.z.toFixed(4))
  document.getElementById("moAccelGrav").innerHTML = info
  
  # Grab the rotation rate from the results
  rotation = eventData.rotationRate
  info = xyz.replace("X", rotation.alpha.toFixed(4))
  info = info.replace("Y", rotation.beta.toFixed(4))
  info = info.replace("Z", rotation.gamma.toFixed(4))
  document.getElementById("moRotation").innerHTML = info

  # console.log(eventData.interval)

  if ave > 0
    # rotate left
    rotate = -1 * ave * 25
  else
    # rotate right
    ave = Math.abs(ave)
    rotate = ave * 25

  # console.log("rotate updated to: " + rotate)

  Tanks.update(
    tank._id,
    $set: {
      rotate: rotate
    }
  )
  return

Template.space.initSpace = (data) ->
  return if TankInit.hasRun
  TankInit.hasRun = true
  
  tank = data.tank
  window.tank = tank # debug
  gamma_buffer = []

  window.addEventListener('devicemotion', deviceMotionHandler, false)
  console.log("init space ", data)

# window events have to be removed manually when leaving page
Template.space.exitRoom = (room) ->
  console.log('player exitRoom', room)
  window.removeEventListener('devicemotion', deviceMotionHandler, false)
  TankInit.hasRun = false


clickMove = (e) ->
  console.log("clicked move", e.target.id)

clickShoot = (e) ->
  console.log("clicked shoot", e.target.id)

Template.space.events =
  "click #move": (e) ->
    clickMove(e)

  "click #shoot": (e) ->
    clickShoot(e)


