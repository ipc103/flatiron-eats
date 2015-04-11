function loadRightSidebar(){
  $.get('/meals/', function(data) {
  debugger;
  $('div.add-on-wrapper').load(document.URL + ' div.add-on-wrapper');

});
}