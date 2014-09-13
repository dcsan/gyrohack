# viewer

player = null

Template.viewer.clip = (v) ->
  decs = 1000
  return Math.round(v*decs)/decs

Template.viewer.rendered = () ->
  player = Players.findOne()
  window.player = player


  n = 100 # points in the line graph

  margin =
    top: 20
    right: 20
    bottom: 20
    left: 40

  width = 960 - margin.left - margin.right
  height = 300 - margin.top - margin.bottom

  # axis
  x = d3.scale.linear().domain([
    0
    n - 1
  ]).range([
    0
    width
  ])
  y = d3.scale.linear().domain([
    -2
    11
  ]).range([
    0
    height
  ])

  # svg and path
  svg = d3.select("#players").append("svg").attr("width", width + margin.left + margin.right).attr("height", height + margin.top + margin.bottom).append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")")
  svg.append("defs").append("clipPath").attr("id", "clip").append("rect").attr("width", width).attr "height", height

  console.log("graph init")

  this.autorun ->
    lg = LineGraphs.findOne({"player_name": "A"})

    line = d3.svg.line().x((d, i) ->
      x i
    ).y((d, i) ->
      y d
    )

    path = svg.append("g").attr("clip-path", "url(#clip)").append("path").datum(lg.data).attr("d", line)
  
    path.attr("d", line).attr("transform", null).transition().duration(500).ease("linear").attr "transform", "translate(" + x(-1) + ",0)"
    return
