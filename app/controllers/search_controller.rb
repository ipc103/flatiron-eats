class SearchController < ApplicationController

	def food_categories
		@restaurants = Restaurant.all
		binding.pry

	end

end
