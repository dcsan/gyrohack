@Players = new Meteor.Collection('Players')

if Meteor.isServer
  Meteor.publish "Players", (query) ->
    console.log("sub.Players", query)
    p = Players.find(query)
    return p

  Players.allow
    insert: () ->
      return true
    update: () ->
      return true
    remove: () ->
      return true
