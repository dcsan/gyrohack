pickBattle = (e) ->
  idx = $(e.target).attr("battleId")
  dclib.sessSet("battleId", idx)
  Router.go("/player_lobby")

Template.battle_lobby.events
  'click .pickBattle': (e) ->
    pickBattle(e)
