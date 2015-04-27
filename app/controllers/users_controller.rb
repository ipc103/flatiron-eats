class UsersController < ApplicationController

  def index

  end

  def show
    @user = User.find(params[:id])

    @meals = @user.get_sorted_meals
    @past_meals = @meals[:past]
    @future_meals = @meals[:future]

    @events = @user.get_sorted_events
    @future_events = @events[:future]
    @past_events = @events[:past]
  end
end
