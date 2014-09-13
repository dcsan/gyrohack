@Rooms = new Meteor.Collection('Rooms')

Meteor.startup ->
  if Meteor.isServer
    console.log("startup rooms")
    Rooms.remove({})
    Rooms.insert({
        name: "the room"
        player_names: []  # a hash of player objects
        status: ""   # not started -> started -> ended
    })
