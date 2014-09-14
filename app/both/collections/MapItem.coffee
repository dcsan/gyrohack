@MapItems = new Meteor.Collection('MapItems')

ITEM_LIFETIME = 2000

if Meteor.isServer
  Meteor.publish "MapItems", (query) ->
    console.log("sub.MapItems", query)
    curs = MapItems.find(query)
    return curs

  MapItems.allow
    insert: () ->
      return true
    update: () ->
      return true
    remove: () ->
      return true

MapItems.helpers

  msg: (txt, obj) ->
    console.log(txt, obj)
    $("#msg").text(txt)

  setProps: (props) ->
    MapItems.update(
      @_id,
      $set: props
    )
    _.extend(@, props)

  deleteMe: () ->
    @msg("delete mapItem #{@_id}")
    MapItems.remove({_id: @_id})

  #FIXME - use realtime not ticks
  tick: () ->
    @age = @age+1
    if @age % 100 == 0
      @msg("tick", @age)
    @setProps({age: @age})
    if @age > ITEM_LIFETIME
      return true
    else
      return false

MapItems.reset = () ->
  console.log("MapItems.reset")
  MapItems.remove({})


MapItems.create = (obj) ->
  obj.state = "new"
  obj.age = 0
  switch obj.type
    when "gold"
      obj.score = 100
    when "bomb"
      obj.score = -100
    else
      console.warn("create item / unknown type")
      obj.score = 100  # default

  res = MapItems.insert(obj)
  return res

updateCount = 0
MapItems.updateAll = (data) ->
  updateCount++
  battleId = data.battleId
  mapItems = MapItems.find({battleId: battleId }).fetch()
  tanks = Tanks.find({battleId: battleId}).fetch()
  _.each mapItems, (item) ->
    kill = item.tick()
    if (kill)
      item.deleteMe()
    else
      _.each tanks, (tank) ->
        # if updateCount % 50 == 0  # debug
          # console.log("updateAll", items)

        if tank.collide(item)
          tank.getItem(item)
          item.deleteMe()

  # console.log("items:", mapItems.count() )
