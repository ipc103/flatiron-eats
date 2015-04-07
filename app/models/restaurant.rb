class Restaurant < ActiveRecord::Base
  has_many :meals
  has_many :resaurant_categories
  has_many :categories, through: :resaurant_categories
end
