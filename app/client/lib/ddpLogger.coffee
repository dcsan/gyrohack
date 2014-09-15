Meteor.startup ->
  if Meteor.settings.public.ddplogLevel > 0
    if Meteor.isClient
      console.log('dev env, starting ddp logs')
      # log sent messages
      _send = Meteor.connection._send
      Meteor.connection._send = (obj) ->
        if Meteor.settings.public.ddplogLevel > 2
          console.log "send", obj
        _send.call this, obj
        return

      
      # log received messages
      Meteor.connection._stream.on "message", (message) ->
        route = Router.current()
        if !route
          console.warn("cant find route")
          return

        thisPath = route.path
        if window.lastPath == thisPath
          window.pageSize += message.length
        else
          ## reset/init page log
          # console.log("new path", thisPath)
          window.lastPath = thisPath
          window.pageSize = message.length

        jsonMessage = JSON.parse(message)
        # console.log(jsonMessage)
        window.jsonMessage = jsonMessage
        if (jsonMessage.msg == 'ready')
          Session.set('ddpSize', window.pageSize)
        if Meteor.settings.public.ddplogLevel > 2
          console.log("#{thisPath} | #{jsonMessage.msg} | #{jsonMessage.collection or '-'} | #{message.length} | #{window.pageSize} ")
        return