Meteor.startup ->
  if Meteor.isServer
    console.log("startup")
    Players.remove({})

    players = [
      {
        name: "Annie"
        room: 1
        pid: 1
        top: 300
        left: 100
        rotate: 0
      }
      {
        name: "Bob"
        room: 1
        pid: 2
        top: 200
        left: 200
        rotate: 60
      }
      {
        name: "Chuck"
        room: 2
        pid: 3
      }
      {
        name: "Dan"
        room: 2
        pid: 4
      }

    ]

    _.each players, (p) ->
      Players.insert p

