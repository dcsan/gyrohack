# viewer

player = null

Template.viewer.clip = (v) ->
  decs = 1000
  return Math.round(v*decs)/decs

Template.viewer.rendered = () ->
  this.autorun ->
    room = Rooms.findOne({name: "the room"})
    window.room = room # debug
    players = []
    for player_name in room.player_names
        players.push Players.findOne({name: player_name})
    return

Template.space.exitRoom = (room) ->
  console.log('viewer exitRoom', room)

