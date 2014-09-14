# viewer

player = null

Template.viewer.clip = (v) ->
  decs = 1000
  return Math.round(v*decs)/decs

Template.viewer.rendered = () ->
  return

Template.player_remote.exitRoom = (room) ->
  console.log('viewer exitRoom', room)

