class Meal < ActiveRecord::Base
  belongs_to :host, class_name: "User"
  has_many :user_meals
  has_many :users, through: :user_meals
  belongs_to :restaurant
  has_many :reviews
  validates :meal_type, :date, :name,  presence: true


  def host?(current_user)
    !!meal.host_id == current_user.id
  end
end
