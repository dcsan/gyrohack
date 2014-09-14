pickBattle = (e) ->
  idx = $(e.target).attr("bid")
  Session.set("battleId", idx)
  Router.go("/battle/#{idx}")

Template.battle_lobby.events
  'click .pickBattle': (e) ->
    pickBattle(e)
