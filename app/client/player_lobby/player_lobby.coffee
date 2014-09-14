pickTank = (e) ->
  tid = $(e.target).attr("tankid")
  console.log("pickTank", tid)
  Session.set("tankId", tid)
  Router.go("/player_remote/#{tid}")

Template.player_lobby.events
  'click .tankPick': (e) ->
    pickTank(e)
    