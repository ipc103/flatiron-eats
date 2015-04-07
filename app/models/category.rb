class Category < ActiveRecord::Base
  has_many :resaurant_categories
  has_many :restaurants, through: :resaurant_categories
end
