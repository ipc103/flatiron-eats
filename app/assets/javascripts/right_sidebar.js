function loadRightSidebar(){
  $.get('/meals/', function(data) {
    $('div.add-on-wrapper').load(document.URL + ' div.add-on-wrapper');
	});
}