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
        points:
          show: true
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

 # $("#tooltip").css({
 #   position: "absolute",
 #   display: "none",
 #   border: "1px solid #fdd",
 #   padding: "2px",
 #   "background-color": "#fee",
 #   opacity: 0.80
 # }).appendTo("body");

#  $("#chartdiv").bind("plothover", function (event, pos, item) {
#    if (item) {
#     var x = item.datapoint[0].toFixed(2), y = item.datapoint[1].toFixed(2);
#     var d = new Date(parseInt(x))
#     var curr_hour = d.getHours();
#     var curr_min = d.getMinutes();
#     var curr_sec = d.getSeconds();
#     var time = " " + curr_hour + ":" + curr_min + ":" + curr_sec;

#     $("#tooltip").html(item.series.label + " at " + time + " = " + y)
#     .css({top: item.pageY+5, left: item.pageX+5})
#     .fadeIn(200);
#   } else {
#     $("#tooltip").hide();
#   }
# });


#  $("#chartdiv").bind("plotselected", function (event, ranges) {

#    $.each(plot.getXAxes(), function(_, axis) {
#     var opts = axis.options;
#     opts.min = ranges.xaxis.from;
#     opts.max = ranges.xaxis.to;
#   });
#    plot.setupGrid();
#    plot.draw();
#    plot.clearSelection();
#  });