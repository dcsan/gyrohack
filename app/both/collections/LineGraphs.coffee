@LineGraphs = new Meteor.Collection('LineGraphs')

Meteor.startup ->
  if Meteor.isServer
    console.log("startup line graphs")
    LineGraphs.remove({})

    # hard code to bind to A's data
    lg = LineGraphs.insert({
      player_name: "A",
      data: []
    })

