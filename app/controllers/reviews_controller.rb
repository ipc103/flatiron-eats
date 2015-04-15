class ReviewsController < ApplicationController
  before_action :load_review, only: [:destroy]
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

  def destroy
    @review.destroy
    redirect_to meal_path(Meal.find(params[:meal_id]))
  end

	private

  def load_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :meal_id)
  end
end
