pickTank = (e) ->
  # debugger;
  tid = $(e.target).attr("tankid")
  tid = parseInt(tid)
  console.log("pickTank tid:", tid)
  Session.set("tankId", tid)

  battleId = Session.get("battleId")
  battleId = parseInt(battleId)
  battle = Battles.findOne({ battleId:battleId })
  tank = Tanks.findOne({idx: tid})
  battle.addTank(tank)
  w = $(window).width()
  h = $(window).height()
  console.log("w =" + w + " h = " + h)
  tank.joinRoom(battle)

  if tid == 1
      #upper left
      tank.setProps({top:0, left:0})
      console.log("tank " + tid)
  else if tid == 2
      #upper right
      tank.setProps({top:0, left:w})
      console.log("tank " + tid)
  else if tid == 3
      #lower left
      tank.setProps({top:h, left:0})
      console.log("tank " + tid)
  else if tid == 4
      #lower right
      tank.setProps({top:h, left:w})
      console.log("tank " + tid)

  Router.go("/player_remote/#{tid}")

  # Router.go("/player_remote/#{tid}")

Template.player_lobby.events
  'click .tankPick': (e) ->
    pickTank(e)
