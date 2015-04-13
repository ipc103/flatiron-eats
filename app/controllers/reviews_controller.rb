class ReviewsController < ApplicationController


	def show
	end

	def new
		 @review = Review.new
	end

	def create
		@review = Review.create(review_params)
		@review.meal_id = params[:meal_id]
		@review.user_id = current_user.id
		@review.save
    redirect_to restaurant_path(@review.restaurant)
	end

	private
  def review_params
    params.require(:review).permit(:rating, :comment, :meal_id)
  end
end
