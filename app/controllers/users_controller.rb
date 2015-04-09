class UsersController < ApplicationController

  def index
    
  end

  def show
    @user = User.find(params[:id])
    @meals = @user.meals
    @events = @user.events
  end
end
