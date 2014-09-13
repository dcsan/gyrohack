newPos = () ->
  console.log("newPos")


Template.arena.rendered = () ->
  newPos()


# http://docs.meteor.com/#eventmaps

Template.arena.events

  'click #p1': (e) ->
    console.log("click p1")
