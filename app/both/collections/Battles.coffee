@Battles = new Meteor.Collection('Battles')

BOOST_SPEED = 10
ROTATE_SPEED = 10

if Meteor.isServer
  Meteor.publish "Battles", (query) ->
    console.log("sub.Battles", query)
    curs = Battles.find(query)
    return curs

  Battles.allow
    insert: () ->
      return true
    update: () ->
      return true
    remove: () ->
      return true

Battles.helpers

  setProps: (props) ->
    Battles.update(
      @_id,
      $set: props
    )
    _.extend(@, props)
    # console.log('player.setProps', props, @)

  msg: (txt) ->
    $("#msg").text(txt)




if Meteor.isServer
  Meteor.startup ->

    Battles.remove({})

    battles = [
      {
        name: "room1"
        bid: 1
        bullets: []
        tanks: []
      }
      {
        name: "room2"
        bid: 2
        bullets: []
        tanks: []
      }
      {
        name: "room3"
        bid: 3
        bullets: []
        tanks: []
      }
      {
        name: "room4"
        bid: 4
        bullets: []
        tanks: []
      }

    ]

    _.each battles, (p) ->
      Battles.insert p

