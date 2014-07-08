# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class @Track extends EventTarget
  points: []
  constructor: (url,map) ->
    EventTarget.call @
    $.get url, (data) =>
      @points = data
      @fire('track-loaded')
      polypoints = @points.map (item) ->
        L.latLng(item.lat, item.lon)
      polyline = L.polyline(polypoints).addTo(map)
      map.fitBounds polyline.getBounds()
  speedProfile: () ->
    @points.map (p) ->
      [new Date(p.timestamp), p.speed]
  heightProfile: () ->
    @points.map (p) ->
      [new Date(p.timestamp), p.alt]
  plot: (elementId) ->
    options =
      series:
        lines:
          show: true
          width: 2
        points:
          show: false
          radius: 2
        shadowSize: 0
      xaxis:
        mode: "time"
        timeformat: "%H:%M:%S"
      yaxes: [ {}, { position: "right" } ]
      grid:
        hoverable: true
        clickable: true
      selection:
        mode: "x"

    plot = $.plot("##{elementId}",
      [
        { label: "Speed",  data: @speedProfile() },
        { label: "Height", data: @heightProfile(), yaxis: 2}
      ],options)

    $("##{elementId}").on "plothover", (event, pos, item) ->
      if item
        x = item.datapoint[0].toFixed(2)
        y = item.datapoint[1].toFixed(2)
        d = new Date(parseInt(x)).toLocaleTimeString()

        $("#tooltip").html(item.series.label + " at " + d + " = " + y).css
          top: item.pageY+5
          left: item.pageX+5
        .fadeIn(200)
      else
        $("#tooltip").hide()
    .on "plotselected", (event, ranges) ->
      $.each plot.getXAxes(), (_, axis) ->
        opts = axis.options
        opts.min = ranges.xaxis.from
        opts.max = ranges.xaxis.to
      plot.setupGrid()
      plot.draw()
      plot.clearSelection()