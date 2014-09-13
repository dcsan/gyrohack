Router.configure
  # notFoundTemplate: 'NotFound',
  # loadingTemplate: 'loading'
  layoutTemplate: "main"

Router.map ->
  @route "home",
    path: "/"
    waitOn: ->
      Meteor.subscribe("Players", {} )
    data: ->
      players: Players.find().fetch()

  @route "lobby",
    path: "/lobby"

  @route "splash",
    path: "/splash"

  @route "mobile",
    path: "/mobile"

  @route "arena",
    path: "/arena/:room"
    waitOn: ->
      roomId = parseInt(@params.room)
      Meteor.subscribe("Players", {room: roomId })
    data: ->
      playerCount: Players.find().count()
      players: Players.find()


  @route "space",
    path: "/space/:room?"
    data: ->
      if @ready()
        playerName = @params.room
        return {
          playerName: playerName
          player: Players.findOne({name: playerName})
        }

    # onRun: ->
    #   Template.space.enterRoom(@params.room)

    onStop: ->
      Template.space.exitRoom(@params.room)

  @route "viewer",
    path: "/viewer/:playerName?"
    data: ->
      playerName: @params.playerName
      player: Players.findOne({name: @params.playerName})

  @route "about"
  return
