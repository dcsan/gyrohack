Router.map ->
  @route "home",
    path: "/"

  @route "lobby",
    path: "/lobby"

  @route "space",
    path: "/space/:cname?"
    data: ->
      cname: @params.cname

  @route "about"
  return
