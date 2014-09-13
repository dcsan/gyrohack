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

  @route "viewer",
    path: "/viewer/:playerName?"
    data: ->
      playerName: @params.playerName
      player: Players.findOne({name: @params.playerName})

  @route "about"
  return
