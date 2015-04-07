class Meal < ActiveRecord::Base
  belongs_to :host, class_name: "User"
  has_many :user_meals
  has_many :users, through: :user_meals
  has_many :restaurants
  has_many :reviews
  validates :meal_type, :date, :name,  presence: true
end
