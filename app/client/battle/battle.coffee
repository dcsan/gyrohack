moveEvent = null
data = null
hasRun = false
tank = null
battle = null

handleKeys = (e) ->
  
  # console.log("@tank", tank)
  switch e.keyCode
    when 39 #right
      tank.doRotate(1)
    when 37 # left
      tank.doRotate(-1)
    when 40 #up
      tank.doBoost(1)
    when 38 #down
      tank.doBoost(-1)
    when 32
      tank.doShoot(-1)
    else
      console.log('unused key:', e.keyCode)

# Template.battle.rendered = ->
#   console.log("enter battleId", this.data.room)
#   enterRoom(this.data)

# window events have to be removed manually when leaving page
Template.battle.exitRoom = (room) ->
  console.log('player exitRoom', room)
  hasRun = false
  $(window).off 'keydown'

Template.battle.initBattle = (data) ->
  return if hasRun
  console.log("initBattle")
  window.data = data
  window.tanks = data.tanks # debug
  battle = data.battle
  console.log("tank1,2", tank)
  $(window).on 'keydown', (e) -> handleKeys(e)
  hasRun = true

clickTank = (e) ->
  console.log("clicked", e.target.id)

Template.battle.events =
  "click .tank-icon": (e) ->
    clickTank(e)
