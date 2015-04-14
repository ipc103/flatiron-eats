class SearchController < ApplicationController

	def food_categories
		@restaurants = Category.find(params[:categories]).collect {|c| c.restaurants}.flatten.uniq
		@categories = Category.all
    @top_10 = Restaurant.top_ten
    respond_to do |f|
      f.html {
        render "restaurants/index"
      }
      f.js{
        render "restaurants/results"
      }
    end
	end

end
