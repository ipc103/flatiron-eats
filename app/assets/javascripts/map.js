$(".meals.index").ready (function(){
  insertMap(40.705329, -74.013970)
})


function insertMap(lat, lng){
  var myLatlng = new google.maps.LatLng(40.705329, -74.013970);
  var mapCanvas = document.getElementById('map-canvas');
  var mapOptions = {
    center: new google.maps.LatLng(lat, lng),
    zoom: 15,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  var map = new google.maps.Map(mapCanvas, mapOptions);
  var img = "assets/logo.png"
  var marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      icon: img,
      title: 'Hello World!'
  });
}