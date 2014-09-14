TANK_SIZE = 100
OFFSET = 100
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

  console.log("battleId #{battleId} battle:", battle)

  battle.addTank(tank)
  tank.joinRoom(battle, battle._id)

  # init tank position (hard coded for 4 tanks)
  w = battle.w
  h = battle.h

  console.log("w =" + w + " h = " + h)
  if tid == 1
      #upper left
      tank.setProps({top:OFFSET, left:OFFSET})
      console.log("tank " + tid)
  else if tid == 2
      #upper right
      tank.setProps({top:OFFSET, left:w - TANK_SIZE - OFFSET})
      console.log("tank " + tid)
  else if tid == 3
      #lower left
      tank.setProps({top:h - TANK_SIZE - OFFSET, left:OFFSET})
      console.log("tank " + tid)
  else if tid == 4
      #lower right
      tank.setProps({top:h - TANK_SIZE - OFFSET, left:w - TANK_SIZE - OFFSET})
      console.log("tank " + tid)

  Router.go("/player_remote/#{tid}")

  # Router.go("/player_remote/#{tid}")

Template.player_lobby.events
  'click .tankPick': (e) ->
    pickTank(e)
