# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

if $("#home-map").length > 0
  map = L.mapbox.map("home-map", null,
    shareControl: true
  ).setView([24.13, -44.56], 3).addControl(L.mapbox.geocoderControl(gon.map_id))

#Customize layers
  watercolor_layer = new L.StamenTileLayer("watercolor")
  name_layer = L.tileLayer("https://{s}.tiles.mapbox.com/v3/" + gon.map_id + "/{z}/{x}/{y}.png",
    attribution: "<a href=\"http://www.mapbox.com/about/maps/\" target=\"_blank\">Terms &amp; Feedback</a>"
  )

  map.addLayer watercolor_layer
  map.addLayer name_layer

#Markers
geojson =
  features: [
    geometry:
      coordinates: [-122.2256401, 37.7698573]
      type: "Point"

    properties:
      description: "SoundMap is an app that allows you to tells stories through sounds and maps. Journalists, travelers and storyteller will get a kick out of it."
      id: "marker-hp3iwdvc"
      "marker-color": "#63b6e5"
      "marker-size": "medium"
      "marker-symbol": ""
      title: "Welcome to SoundMap"

    type: "Feature"
  ,
    geometry:
      coordinates: [2.35337831438349, 48.8374883252818]
      type: "Point"

    properties:
      description: "...Add sounds, photos and text to a map. "
      id: "marker-hp3izy7a"
      "marker-color": "#63b6e5"
      "marker-size": "medium"
      "marker-symbol": ""
      title: "Paris"

    type: "Feature"
  ,
    geometry:
      coordinates: [121.352146168479, 31.0917975938839]
      type: "Point"

    properties:
      description: "Share you maps with friends! "
      id: "marker-hp3j2iya"
      "marker-color": "#63b6e5"
      "marker-size": "medium"
      "marker-symbol": ""
      title: "Shanghai"

    type: "Feature"
  ]
  id: "laurenbenichou.gh8c0187"
  type: "FeatureCollection"

markers = L.mapbox.markerLayer(geojson).addTo(map)
chapters = []
markers.eachLayer (chapter) ->
  chapters.push chapter
  chapters


# First popup open on load
chapters[0].openPopup()
a = chapters[0].feature.geometry.coordinates
map.setView [a[1], a[0]], 3

#Click action to move from one marker to the next
i = -1
$("#next").on "click", ->
  i = (i + 1) % chapters.length
  c = chapters[i].feature.geometry.coordinates
  map.setView [c[1], c[0]], 3
  chapters[i].openPopup()