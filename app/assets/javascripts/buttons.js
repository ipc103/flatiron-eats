$(function(){
  $("#map-canvas").on("click", "input.btn-info.join", (function(){
    var mealID = $(this).parent().attr("data-meal-id")
    var $button = $(this)
    $.ajax({
      url: "/user_meals",
      type: "POST",
      data: {"meal_id": mealID},
      context: $button,
      dataType: "json",

      complete: function(response){
        this.removeClass( "btn-info join" );
        this.addClass( "btn-danger remove" );
        this.attr("value", "Remove this Meal!");
      }
    })
  }))
})

$(function(){
  $("#map-canvas").on("click", "input.btn-danger.cancel", (function(){
    var mealID = $(this).parent().attr("data-meal-id")
    var $button = $(this)
    $.ajax({
      url: "/meals/" + mealID,
      type: "DELETE",
      data: {"meal_id": mealID},
      context: $button,
      dataType: "json",
      complete: function(response){
        alert("Successfully Cancelled Meal!")
        $.getJSON('/meals', function(data){
          insertMealsMap(40.705329, -74.013970, data);
        }) 
      }
    })
  }))
})

$(function(){
  $("#map-canvas").on("click", "input.btn-danger.remove", (function(){
    var $button = $(this)
    var mealID = $(this).parent().attr("data-meal-id")
    $.ajax({
      url: "/user_meals/" + mealID,
      type: "DELETE",
      data: {"meal_id": mealID},
      context: $button,
      dataType: "json",
      complete: function(response){
        this.removeClass( "btn-danger remove" );
        this.addClass( "btn-info join" );
        this.attr("value", "Join This Meal!");
      }
    })
  }))
})