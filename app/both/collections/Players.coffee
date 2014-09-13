@Players = new Meteor.Collection('Players')

if Meteor.isServer
  Meteor.publish "Players", (query) ->
    console.log("sub.Players", query)
    p = Players.find(query)
    return p

