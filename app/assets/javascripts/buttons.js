$(function(){
  $("#map-canvas").on("click", "input.btn-info", (function(){
    var mealID = $(this).parent().attr("data-meal-id")
    var $button = $(this)
    $.ajax({
      url: "/user_meals",
      type: "POST",
      data: {"meal_id": mealID},
      context: $button,
      dataType: "json",

      complete: function(response){
        this.removeClass( "btn-info" );
        this.addClass( "btn-danger" );
        this.attr("value", "Remove this Meal!");
      }
    })
  }))
})

$(function(){
  $("#map-canvas").on("click", "input.btn-danger", (function(){
    var $button = $(this)
    var mealID = $(this).parent().attr("data-meal-id")
    $.ajax({
      url: "/user_meals/" + mealID,
      type: "DELETE",
      data: {"meal_id": mealID},
      context: $button,
      dataType: "json",
      complete: function(response){
        this.removeClass( "btn-danger" );
        this.addClass( "btn-info" );
        this.attr("value", "Join This Meal!");
      }
    })
  }))
})