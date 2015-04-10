function insertRestaurantPins(map, data, infowindow){
  var infowindows = new Array ();
  for (var i = data["restaurants"].length - 1; i >= 0; i--) {
    var pins, html, pinLatLng, pinMarkers;
    pins = data["restaurants"][i];
    html = '<h4>'+pins['name']+'</h4>'+'<p>'+pins['address_line1']+'</p>'+ '<p>'+ pins['phone']+'</p>' + '<a href="' + pins['menu']+ '">Menu</a>';
    pinLatLng = new google.maps.LatLng(parseFloat(pins['lat']), parseFloat(pins['lng']));
    pinMarkers = new google.maps.Marker({position: pinLatLng, map: map, animation: google.maps.Animation.Drop});
    infowindows[i] = new google.maps.InfoWindow();
    // debugger;
    infowindows[i].setContent(html);
    var prevOpenWindow = false;
    google.maps.event.addListener(pinMarkers, "click", (function(pinMarkers, i) {
        return function() {
            if (prevOpenWindow) {
              prevOpenWindow.close();
            }
            prevOpenWindow = infowindows[i]
            infowindows[i].open(map, pinMarkers);
        }
      })(pinMarkers, i));
  };
  
}