$(function() {
  $( "#category-search" ).on("click", function(){
    $button = $(this)
    $( "div#search-boxes" ).slideToggle('slow', function(){
      if ( $button.html() === 'Display Search Options'){
        $button.html('Hide Search Options');
      } else {
        $button.html('Display Search Options')
      }
        
    })
  })
});