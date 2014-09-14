@dclib = {}

dclib.sessSet = (k, v) ->
  console.log("sessSet", k, v)
  Session.set(k, v)