class MealsController < ApplicationController

  def index
    @meals = Meal.all
  end

  def show
    @meal = Meal.find(params[:id])
    @users = @meal.users
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

  def new_user_meal
    UserMeal.create(user_id: current_user.id, meal_id: params[:meal_id])
    redirect_to meals_path
  end

  def destroy_user_meal
    UserMeal.where(user_id: current_user.id, meal_id: params[:meal_id]).last.destroy
    redirect_to meals_path
  end

  def destroy
    Meal.find(params[:id]).destroy
    redirect_to meals_path
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :restaurant_id, :host_id, :email, :date, :meal_type)
  end
end
