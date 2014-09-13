newPos = () ->
  console.log("newPos")

Template.arena.rendered = () ->
  newPos()


# http://docs.meteor.com/#eventmaps

Template.arena.events

  'click #p1': (e) ->
    console.log("click p1")
    px = _.random(500)
    py = _.random(500)
    $("#p1").velocity({
      top: py
      left: px
    })
