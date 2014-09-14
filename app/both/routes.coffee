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
    layoutTemplate: "splash"

  @route "controls",
    path: "/controls"
    layoutTemplate: "controls"

  @route "remote",
    path: "/remote"
    layoutTemplate: "remote"

  @route "mobile",
    path: "/mobile"

  @route "battle_lobby",
    path: "/battle_lobby"
    waitOn: ->
      Meteor.subscribe("Battles", {} )
    data: ->
      battleCount: Battles.find().count()
      battles: Battles.find({}, {sort: {bid:1}})


  @route "player_lobby",
    path: "/player_lobby"
    waitOn: ->
      # roomId = parseInt(@params.room)
      [
        Meteor.subscribe("Tanks", {} ),
        Meteor.subscribe("Battles", {} )
      ]

    data: ->
      tanks: Tanks.find()

  @route "battle",
    path: "/battle/:battleId"
    waitOn: ->
      [
        Meteor.subscribe("Tanks", {room: parseInt(@params.room) }),
        Meteor.subscribe("Battles", {bid: parseInt(@params.room) }),
        Meteor.subscribe("Bullets", {bid: parseInt(@params.room) })
      ]
    data: ->
      if @ready()
        @blob = {
          tankCount: Tanks.find().count()
          tanks: Tanks.find({battleId: parseInt(@params.battleId)})
          battle: Battles.find({bid: @params.bid})
        }
        Template.battle.initBattle(@blob)
        return @blob
        
    # onAfterAction: ->
    #   @blob = {
    #     tankCount: Tanks.find().count()
    #     tanks: Tanks.find()
    #   }

    onStop: ->
      Template.battle.exitRoom(@params.battleId)

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

  @route "about",
    path: "/about"

  @route "admin",
    path: "/admin"

  @route "reset",
    path: "/reset/:wot?"
    where: 'server'

    action: ->
      wot = @params.wot
      console.log("reset")
      Tanks.reset()
      Players.reset()
      Battles.reset()
      @response.writeHead(200, {'Content-Type': 'text/html'})
      @response.end("reset: done")

  return
