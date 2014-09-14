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

  @route "splash",
    path: "/splash"
    layoutTemplate: "splash"

  @route "battle_lobby",
    path: "/battle_lobby"
    waitOn: ->
      Meteor.subscribe("Battles", {} )
    data: ->
      battleCount: Battles.find().count()
      battles: Battles.find({}, {sort: {battleId:1}})


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
        Meteor.subscribe("Battles", {battleId: parseInt(@params.battleId) })
        Meteor.subscribe("Tanks", {battleId: parseInt(@params.battleId) })
        Meteor.subscribe("MapItems", {battleId: parseInt(@params.battleId) })
      ]
    data: ->
      if @ready()
        battleId = parseInt(@params.battleId)
        mapItems = MapItems.find({battleId: battleId})
        @blob = {
          tankCount: Tanks.find().count()
          itemCount: mapItems.count()
          tanks: Tanks.find({battleId: battleId})
          battle: Battles.findOne({battleId: battleId })
          mapItems: mapItems
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
      [
        # fixme - just current players battle?
        Meteor.subscribe("Tanks", {} ),
        Meteor.subscribe("Battles", {} )
      ]
    data: ->
      if @ready()
        tankId = parseInt(@params.tankId) # not using players for now
        tank = Tanks.findOne({idx: tankId})
        battle = Battles.findOne({battleId:tank.battleId})
        @blob = {
          tankId: tankId
          tank: tank
          battle: battle
        }
        Template.player_remote.initSpace(@blob)
        return @blob
    onStop: ->
      Template.player_remote.exitRoom(@params.tankId)

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
      MapItems.reset()
      @response.writeHead(200, {'Content-Type': 'text/html'})
      @response.end("reset: done")

  return
