function insertRestaurantPins(map, data, infowindow){
  var infowindows = new Array ();
  for (var i = data["restaurants"].length - 1; i >= 0; i--) {
    var pins, html, phone, menu, pinLatLng, pinMarkers;
    pins = data["restaurants"][i];
    
    html = '<h4>'+pins['name']+'</h4>'+'<p>'+pins['address_line1']+'</p>'
    if ( pins["phone"]) {
      html += '<p>'+ pins['phone']+'</p>';
    }
    if ( pins['menu']) {
      html += '<a href="' + pins['menu']+ '">Menu</a>';
    }
    
    html += '<p><a href="/meals/new?restaurant_id=' + pins['id'] + '">Create a New Meal</a></p>';
    pinLatLng = new google.maps.LatLng(parseFloat(pins['lat']), parseFloat(pins['lng']));
    pinMarkers = new google.maps.Marker({position: pinLatLng, map: map, animation: google.maps.Animation.DROP});
    infowindows[i] = new google.maps.InfoWindow();
    infowindows[i].setContent(html);
    var prevOpenWindow = false;
    google.maps.event.addListener(pinMarkers, "click", (function(pinMarkers, i) {
        return function() {
            if (prevOpenWindow) {
              prevOpenWindow.close();
            }
            prevOpenWindow = infowindows[i];
            infowindows[i].open(map, pinMarkers);
        };
      })(pinMarkers, i));
  }
  
}