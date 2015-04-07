class User < ActiveRecord::Base
  has_many :user_meals
  has_many :meals, through: :user_meals
  has_many :reviews
  has_many :events, foreign_key: "host_id", class_name: "Meal"
  validates :email, presence: true
end
