pickTank = (e) ->
  # debugger;
  tid = $(e.target).attr("tankid")
  tid = parseInt(tid)
  console.log("pickTank tid:", tid)
  Session.set("tankId", tid)

  battleId = Session.get("battleId")
  battleId = parseInt(battleId)
  battle = Battles.findOne( {bid:battleId} )
  tank = Tanks.findOne({idx: tid})
  battle.addTank(tank)

  Router.go("/player_remote/#{tid}")

  # Router.go("/player_remote/#{tid}")

Template.player_lobby.events
  'click .tankPick': (e) ->
    pickTank(e)
