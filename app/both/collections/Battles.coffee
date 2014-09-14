@Battles = new Meteor.Collection('Battles')

BOOST_SPEED = 10
ROTATE_SPEED = 10

if Meteor.isServer
  Meteor.publish "Battles", (query) ->
    console.log("sub.Battles", query)
    curs = Battles.find(query)
    return curs

  Battles.allow
    insert: () ->
      return true
    update: () ->
      return true
    remove: () ->
      return true


Battles.reset = () ->
  console.log("Battles.reset")
  Battles.remove({})
  battles = [
    {
      name: "room1"
      bid: 1
    }
    {
      name: "room2"
      bid: 2
    }
    {
      name: "room3"
      bid: 3
    }
    {
      name: "room4"
      bid: 4
    }
  ]

  _.each battles, (p) ->
    p.players = []
    p.tanks = []
    Battles.insert p

##-------------  helpers
Battles.helpers

  setProps: (props) ->
    Battles.update(
      @_id,
      $set: props
    )
    _.extend(@, props)
    # console.log('player.setProps', props, @)

  msg: (txt) ->
    $("#msg").text(txt)

  playerCount: () ->
    return @players.length

  tankCount: () ->
    return @tanks.length

  addTank: (tank) ->
    console.log("battle.addTank #{tank._id} to battle #{@bid}")
    @tanks.push(tank._id)
    @setProps(tanks: @tanks) # save it

  removeTank: (tank) ->
    console.log("battle.removeTank tank #{tank._id} to battle #{@bid}")
    tanks = _.reject @tanks, (tankId) -> tankId == tank._id
    @setProps(tanks: tanks)


