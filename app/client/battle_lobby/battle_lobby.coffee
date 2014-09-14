pickBattle = (e) ->
  idx = $(e.target).attr("bid")
  Session.set("battleId", idx)
  Router.go("/player_lobby")

Template.battle_lobby.events
  'click .pickBattle': (e) ->
    pickBattle(e)
