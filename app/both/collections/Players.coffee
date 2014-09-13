@Players = new Meteor.Collection('Players')

Meteor.startup ->
  if Meteor.isServer
    console.log("startup")
    Players.remove({})
    p = Players.insert({
      name: "A"
    })