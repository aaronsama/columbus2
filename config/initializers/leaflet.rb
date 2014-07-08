LEAFLET = Hash.new
LEAFLET[:osm] = {
  url: "http://{s}.tile.osm.org/{z}/{x}/{y}.png",
  attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
}
LEAFLET[:cyclemap] = {
  url: 'http://{s}.tile.opencyclemap.org/cycle/{z}/{x}/{y}.png',
  attribution: '&copy; OpenCycleMap, Map data &copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
}