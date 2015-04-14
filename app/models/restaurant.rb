class Restaurant < ActiveRecord::Base
  has_many :meals
  has_many :restaurant_categories
  has_many :categories, through: :restaurant_categories
  has_many :reviews, through: :meals

  def average_rating
  	if self.reviews.length > 0
	  	total = 0
	  	self.reviews.each do |review|
	  		total += review.rating
	  	end
	  	@average_rating = total/self.reviews.length
		else
			@average_rating = 0
  	end
  end

  def self.top_rated
    Restaurant.joins(:reviews).group("restaurants.id").order("avg(reviews.rating)").limit(10)

  end

  def self.most_visited
  end

  def self.top_rated_this_week
  end
end
