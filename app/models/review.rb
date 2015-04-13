class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :meal
  delegate :restaurant, :to => :meal, :allow_nil => true
  validates :rating, presence: true
end
