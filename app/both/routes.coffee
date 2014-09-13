Router.configure
  # notFoundTemplate: 'NotFound',
  # loadingTemplate: 'loading'
  layoutTemplate: "main"

Router.map ->
  @route "home",
    path: "/"

  @route "lobby",
    path: "/lobby"

  @route "space",
    path: "/space/:room?"
    data: ->
      playerName = "A"
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
