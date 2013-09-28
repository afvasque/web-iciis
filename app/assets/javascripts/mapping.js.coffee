# SOURCE: http://larsgebhardt.de/using-google-maps-api-with-ruby-on-rails/

gm_init = ->
  gm_center = new google.maps.LatLng(-36.45, -70.66)
  gm_map_type = google.maps.MapTypeId.ROADMAP
  map_options = {center: gm_center, zoom: 4,9, mapTypeId: gm_map_type, disableDefaultUI:true}
  new google.maps.Map(@map,map_options);

create_markers = (latlongs,map) ->
  bounds = new google.maps.LatLngBounds
  for l in latlongs
    m = new google.maps.Marker
      position : new google.maps.LatLng(l[0],l[1]),
      map : map;
    bounds.extend(new google.maps.LatLng(l[0],l[1]))
  map.fitBounds(bounds);

$ ->
  map = gm_init()
  create_markers(latlongs,map);