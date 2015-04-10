class Meal < ActiveRecord::Base
  belongs_to :host, class_name: "User"
  has_many :user_meals
  has_many :users, through: :user_meals
  belongs_to :restaurant
  has_many :reviews
  validates :meal_type, :date, :name,  presence: true


  def going?(user)
    self.users.include?(user)
  end
end
