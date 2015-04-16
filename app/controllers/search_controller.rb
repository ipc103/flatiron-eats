class SearchController < ApplicationController

	def food_categories
		@restaurants = Category.find(params[:categories]).collect {|c| c.restaurants}.flatten.uniq

    respond_to do |f|
      f.js{
        render "restaurants/results"
      }
    end
	end

end
