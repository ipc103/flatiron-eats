class MealsController < ApplicationController

  def index
    @meals = Meal.all
  end

  def new
    if params[:restaurant_id]
      @restaurant = Restaurant.find(params[:restaurant_id])
    end
    @meal = Meal.new
  end

  def create
    @meal = Meal.create(meal_params)
    redirect_to meals_path
  end


  private

  def meal_params
    params.require(:meal).permit(:name, :restaurant_id, :host_id, :email, :date, :meal_type)
  end
end
