moveEvent = null
data = null
@Battle = {}

handleKeys = (e) ->
  tank = Battle.tanks[0]
  console.log("@tank", tank)
  switch e.keyCode
    when 69
      console.log('edit')
      url = "/komikEditScene/#{data.params.chapter}/#{data.params.scene}"
      window.open(url, 'editor')
    when 39
      tank.rotate("right")
    when 37 # back
      tank.rotate("left")
    when 32
      tank.shoot()
    when 38
      tank.boost()
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
  console.log("enterRoom")
  window.data = data
  tank1 = Tanks.findOne()
  tank2 = data.tanks.fetch()[0]
  console.log("tank1,2", tank1, tank2)
  Battle.tanks = [tank1, tank2]
  $(window).on 'keydown', (e) -> handleKeys(e)
