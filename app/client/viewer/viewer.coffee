# viewer

player = null

Template.viewer.clip = (v) ->
  decs = 1000
  return Math.round(v*decs)/decs

Template.viewer.rendered = () ->
  return

Template.space.exitRoom = (room) ->
  console.log('viewer exitRoom', room)

