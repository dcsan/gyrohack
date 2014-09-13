moveEvent = null
data = null
@Battle = {
  hasRun: false
}

handleKeys = (e) ->
  tank = Battle.tanks[0]
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
  $(window).off 'keydown'

Template.battle.initBattle = (data) ->
  return if Battle.hasRun
  console.log("initBattle")
  window.data = data
  tank1 = Tanks.findOne()
  tank2 = data.tanks.fetch()[0]
  console.log("tank1,2", tank1, tank2)
  Battle.tanks = [tank1, tank2]
  $(window).on 'keydown', (e) -> handleKeys(e)
  Battle.hasRun = true