
Meteor.startup ->
  if Meteor.isServer
    console.log("startup")
    Players.remove({})

    players = [
      {
        name: "Annie"
        room: 1
      }
      {
        name: "Bob"
        room: 1
      }
      {
        name: "Chuck"
        room: 2
      }
      {
        name: "Dan"
        room: 2
      }

    ]

    _.each players, (p) ->
      Players.insert p

