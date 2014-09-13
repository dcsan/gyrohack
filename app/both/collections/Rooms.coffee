@Rooms = new Meteor.Collection('Rooms')

Meteor.startup ->
  if Meteor.isServer
    console.log("startup rooms")
    Rooms.remove({})
    Rooms.insert({
        name: "the room"
        players: []
        status: ""   # not started -> started -> ended
    })
