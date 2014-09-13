Router.map ->
  @route "home",
    path: "/"

  @route "lobby",
    path: "/lobby"

  @route "space",
    path: "/space/:cname?"
    data: ->
      cname: @params.cname

  @route "viewer",
    path: "/viewer/:playerName?"
    data: ->
      playerName: @params.playerName
      player: Players.findOne({name: @params.playerName})

  @route "about"
  return
