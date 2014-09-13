@Players = new Meteor.Collection('Players')

Meteor.startup ->
  if Meteor.isServer
    console.log("startup")
    Players.remove({})
    Players.insert({
      name: "A"
    })
    Players.insert({
      name: "B"
    })
