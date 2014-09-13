moveEvent = null
data = null

@tank = new Tank

window.tank = tank

handleKeys = (e) ->
  # console.log("key", e)
  switch e.keyCode
    when 69
      console.log('edit')
      url = "/komikEditScene/#{data.params.chapter}/#{data.params.scene}"
      window.open(url, 'editor')
    when 39
      @tank.rotate("right")
    when 37 # back
      @tank.rotate("left")
    when 32
      @tank.shoot()
    when 38
      @tank.boost()
    else
      console.log('unused key:', e.keyCode)

Template.battle.rendered = ->
  console.log("rendered")
  enterRoom(this.data)

enterRoom = (data) ->
  console.log("enterRoom", data)
  $(window).on 'keydown', (e) -> handleKeys(e)

# window events have to be removed manually when leaving page
Template.battle.exitRoom = (room) ->
  console.log('player exitRoom', room)
  $(window).off 'keydown'

