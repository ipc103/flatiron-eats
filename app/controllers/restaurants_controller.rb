class RestaurantsController < ApplicationController

	def index
		@restaurants = Restaurant.all
    @categories = Category.order(:name)
    @top_10 = Restaurant.top_ten
    respond_to do |f|
      f.html
      f.json {
        render json: {
          restaurants: @restaurants.map(&:attributes)
        }
      }
    end
	end

	def show
		@restaurant = Restaurant.find(params[:id])
	end
end
