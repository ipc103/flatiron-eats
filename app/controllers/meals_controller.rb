class MealsController < ApplicationController
  before_action :load_meal, only: [:show, :edit, :destroy, :update]
  def index
    @meals = Meal.upcoming
    respond_to do |f|
      f.html
      f.json {
        render json: {meals: @meals.map do |meal| 
          {
            id: meal.id, 
            name: meal.name,
            date: meal.date, 
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
    @users = @meal.users
  end

  def new
    if params[:restaurant_id]
      @restaurant = Restaurant.find(params[:restaurant_id])
    end
    @meal = Meal.new
  end

  def create
    params[:meal][:date] = DateTime.strptime(params[:meal][:date], "%m/%d/%Y %H:%M %p").change(:offset => "-0400")
    @meal = Meal.create(meal_params)
    redirect_to user_path(current_user)
  end

  def edit
    
  end

  def update
    @meal.update(meal_params)
    redirect_to meal_path(@meal)
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
    if !@meal.going?(current_user)
      UserMeal.create(user_id: current_user.id, meal_id: params[:meal_id])
    end
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
  def load_meal
    @meal = Meal.find(params[:id])
  end
  def meal_params
    params.require(:meal).permit(:name, :restaurant_id, :host_id, :email, :date, :meal_type)
  end
end
