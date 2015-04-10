function insertRestaurantPins(map, data, infowindow){
  var infowindows = new Array (); // creates an array to hold the info windows for each restaurant
  for (var i = data["meals"].length - 1; i >= 0; i--) {
    var pins, html, pinLatLng, pinMarkers, button;
    pins = data["meals"][i];
    if (pins["restaurant"]["attending"]) {
      var button = '<div id="meal-pin" data-meal-id='+ pins['id']+'><input type="submit" name="commit" value="Remove this Meal!" class="btn btn-danger"></div>';
    } else {
      var button = '<div id="meal-pin" data-meal-id='+ pins['id']+'><input type="submit" name="commit" value="Join This Meal!" class="btn btn-info"></div>';
    };
    
    html = '<h4>'+pins['restaurant']['name']+'</h4>'+'<p>'+pins['restaurant']['address_line1']+'</p>'+ '<p>'+ pins['restaurant']['phone']+'</p>' + '<a href="' + pins['restaurant']['menu']+ '">Menu</a>' + button;
    pinLatLng = new google.maps.LatLng(parseFloat(pins['restaurant']['lat']), parseFloat(pins['restaurant']['lng']));
    pinMarkers = new google.maps.Marker({position: pinLatLng, map: map, animation: google.maps.Animation.Drop});
    infowindows[i] = new google.maps.InfoWindow();
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


$(function(){
  $("#map-canvas").on("click", "input.btn", (function(){
    var mealID = $(this).parent().attr("data-meal-id")
    $.ajax({
      url: "/user_meals",
      type: "POST",
      data: {"meal_id": mealID},
      dataType: "json",
      success: function(response){
        alert("successful!");
      }
    })
  }))
})


// $.ajax({
//        url: url,
//        data: '{"alias": "Udetemperatur"}',
//        type: "POST",
//        contentType: "application/json; charset=utf-8",
//        dataType: "text",  // not "json" we'll parse
//        success:
//                function(res) {
//                    alert('Received response: ' + res);
//                    }
//    });