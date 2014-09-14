Router.configure
  # notFoundTemplate: 'NotFound',
  # loadingTemplate: 'loading'
  layoutTemplate: "main"

Router.map ->
  @route "home",
    path: "/"
    waitOn: ->
      Meteor.subscribe("Tanks", {} )
    data: ->
      tanks: Tanks.find().fetch()

  @route "lobby",
    path: "/lobby"

  @route "splash",
    path: "/splash"

  @route "controls",
    path: "/controls"

  @route "mobile",
    path: "/mobile"


  @route "player_lobby",
    path: "/player_lobby"
    waitOn: ->
      roomId = parseInt(@params.room)
      Meteor.subscribe("Players", {} )
    data: ->
      playerCount: Players.find().count()
      players: Players.find()

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

  @route "player_remote",
    path: "/player_remote/:tankId"
    waitOn: ->
      Meteor.subscribe("Tanks", {room: parseInt(@params.tankId) })
    data: ->
      if @ready()
        tankId = parseInt(@params.tankId) # not using players for now
        @blob = {
          tankId: tankId
          tank: Tanks.findOne({pid: tankId})
        }
        Template.player_remote.initSpace(@blob)
        return @blob
    onStop: ->
      Template.player_remote.exitRoom(@params.tankId)

  @route "viewer",
    path: "/viewer/:playerName?"
    data: ->
      playerName: @params.playerName
      player: Players.findOne({name: @params.playerName})

  @route "about"
  return
