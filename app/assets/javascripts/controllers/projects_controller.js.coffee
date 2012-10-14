# INDEX
jQuery ($) ->
  return unless $('body.projects.index').length > 0

  if WS.local_projects && WS.local_projects.length > 0
    lat = WS.local_projects[0].latitude
    lng = WS.local_projects[0].longitude
  else
     lat = WS.current_user.lat
     lng = WS.current_user.lng

  map_opts =
    div: '#project_map'
    lat: lat
    lng: lng

  WS.project_map = new WS.AreaMap( map_opts, WS.local_projects )

success = (position) ->
    $('#project_latitude').val(position.coords.latitude)
    $('#project_longitude').val(position.coords.longitude)
    $('#map_preview iframe').remove()
    $('#map_preview').append('<iframe width="100%" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=' + position.coords.latitude + ',' + position.coords.longitude + '&amp;ie=UTF8&amp;output=embed"></iframe>')

error = () ->
  alert("Error getting location")

$ () ->
  $('.geolocate').click () ->
    navigator.geolocation.getCurrentPosition(success, error)


# SHOW
jQuery ($) ->
  return unless $('body.projects.show').length > 0

  $streets = $('#streetview')

  latlng = new google.maps.LatLng($streets.data('lat'), $streets.data('lng'))
  WS.project_street_view = new google.maps.StreetViewPanorama(document.getElementById('streetview'), {visible: true, position: latlng})
