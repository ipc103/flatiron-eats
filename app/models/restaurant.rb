class Restaurant < ActiveRecord::Base
  has_many :meals
  has_many :restaurant_categories
  has_many :categories, through: :restaurant_categories
  has_many :reviews, through: :meals
end
