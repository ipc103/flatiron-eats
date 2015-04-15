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

  def hosting?(user)
    self.host == user
  end

  def self.upcoming
    self.where("date BETWEEN ? AND ?", 1.hour.ago, 7.day.from_now)
  end

  def self.past
    self.where("date BETWEEN ? AND ?", 5.day.ago, Time.now)
  end
end
