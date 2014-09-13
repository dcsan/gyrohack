class @Tank

  rotate: (dir) ->
    $("#msg").text(dir)

  shoot: () ->
    $("#msg").text("shoot")

  boost: () ->
    $("#msg").text("boost")
