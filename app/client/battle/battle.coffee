moveEvent = null
data = null
hasRun = false
tank = null
battle = null
tanks = null

handleKeys = (e) ->
  
  # console.log("@tank", tank)
  switch e.keyCode
    when 39, 68 #right
      tank.doRotate(1)
    when 37, 65 # left
      tank.doRotate(-1)
    when 40, 87 #up
      tank.doBoost(1)
    when 38, 83 #down
      tank.doBoost(-1)
    when 32, 13
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
  console.log("initBattle", data)
  window.data = data # debug
  tanks = data.tanks.fetch()
  console.log("tankCount", tanks.length)
  tank = tanks[0] # debug first tank's handle
  window.tank = tank # debug

  battle = data.battle
  window.battle = battle # debug

  $(window).on 'keydown', (e) -> handleKeys(e)
  hasRun = true

clickTank = (e) ->
  console.log("clicked", e.target.id)

clickMap = (e) ->
  battle.addItem(e, battle)

Template.battle.events =
  "click .tank-icon": (e) ->
    clickTank(e)

  "click #battle_map": (e) ->
    clickMap(e)

if Meteor.isClient
  update = () ->
    console.log("update")
  Meteor.setInterval(update, 50)


