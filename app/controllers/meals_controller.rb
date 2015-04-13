class MealsController < ApplicationController

  def index
    @meals = Meal.all
    respond_to do |f|
      f.html
      f.json {
        render json: {meals: @meals.map do |meal| 
          {
            id: meal.id, 
            name: meal.name, 
            restaurant: {
              name: meal.restaurant.name, 
              lat: meal.restaurant.lat, 
              lng: meal.restaurant.lng, 
              address_line1: meal.restaurant.address_line1, 
              phone: meal.restaurant.phone, 
              menu: meal.restaurant.menu, 
              attending: meal.going?(current_user),
              hosting: meal.hosting?(current_user)
            },
            attendees: meal.users.map(&:name)
          }
        end
      }
    }
    end
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

  def destroy
    Meal.find(params[:id]).destroy
    respond_to do |f|
      f.html{
        redirect_to meals_path
      }
      f.js{
        render 'restaurants/right_sidebar'
      }
    end
  end

  def new_user_meal
    @meal = Meal.find(params[:meal_id])
    UserMeal.create(user_id: current_user.id, meal_id: params[:meal_id])
    respond_to do |f|
      f.html{
        redirect_to meals_path
      }
      f.js{
        render 'restaurants/right_sidebar'
      }
    end
  end

  def destroy_user_meal
    UserMeal.where(user_id: current_user.id, meal_id: params[:meal_id]).last.destroy
    respond_to do |f|
      f.html{
        redirect_to meals_path
      }
      f.js{
        render 'restaurants/right_sidebar'
      }
    end
  end


  private
  def meal_params
    params.require(:meal).permit(:name, :restaurant_id, :host_id, :email, :date, :meal_type)
  end
end
