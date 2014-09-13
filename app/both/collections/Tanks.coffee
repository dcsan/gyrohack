@Tanks = new Meteor.Collection('Tanks')

if Meteor.isServer
  Meteor.publish "Tanks", (query) ->
    console.log("sub.Tanks", query)
    curs = Tanks.find(query)
    return curs

  Tanks.allow
    insert: () ->
      return true
    update: () ->
      return true
    remove: () ->
      return true

Tanks.helpers
  
  msg: (txt) ->
    $("#msg").text(txt)
  
  boost: (vec) ->
    @msg("boost #{vec}")

  rotate: (deg) ->
    @msg("turn #{deg}")

  shoot: (vec) ->
    @msg("boost #{vec}")
