@MapItems = new Meteor.Collection('MapItems')

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

  setProps: (props) ->
    MapItems.update(
      @_id,
      $set: props
    )
    _.extend(@, props)

  tick: () ->
    setProps({age: @age+1})

MapItems.reset = () ->
  console.log("MapItems.reset")
  MapItems.remove({})


MapItems.create = (obj) ->
  obj.state = "new"
  obj.age = 0
  MapItems.insert(obj)