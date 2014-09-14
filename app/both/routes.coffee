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

  @route "controls",
    path: "/controls"
    layoutTemplate: "controls"

  @route "remote",
    path: "/remote"

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

  @route "battle",
    path: "/battle/:room"
    waitOn: ->
      Meteor.subscribe("Tanks", {room: parseInt(@params.room) })
    data: ->
      if @ready()
        @blob = {
          tankCount: Tanks.find().count()
          tanks: Tanks.find()
        }
        Template.battle.initBattle(@blob)
        return @blob
        
    # onAfterAction: ->
    #   @blob = {
    #     tankCount: Tanks.find().count()
    #     tanks: Tanks.find()
    #   }

    onStop: ->
      Template.battle.exitRoom(@params.room)

  @route "space",
    path: "/space/:room?"
    data: ->
      playerName = @params.room
      return {
        playerName: playerName
        player: Players.findOne({name: playerName})
      }
    onStop: ->
      Template.space.exitRoom(@params.room)

  @route "viewer",
    path: "/viewer/:playerName?"
    data: ->
      playerName: @params.playerName
      player: Players.findOne({name: @params.playerName})

  @route "about"
  return
