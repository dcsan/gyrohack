# viewer

player = null

Template.viewer.clip = (v) ->
  decs = 1000
  return Math.round(v*decs)/decs

Template.viewer.rendered = () ->
  player = Players.findOne()
  window.player = player