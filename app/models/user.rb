class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:github]

  has_many :user_meals
  has_many :meals, through: :user_meals
  has_many :reviews
  has_many :events, foreign_key: "host_id", class_name: "Meal"
  validates :email, presence: true


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.image = auth.info.image
      user.password = Devise.friendly_token[0,20]
    end
  end

  # The two methods below are nearly identical and can probably be refactored into
  # one pretty nicely. Especially if something similar will be done a third time.
  # If you do this ^ don't forget to update UsersController as well :)
  def get_sorted_meals
    meals = self.meals
    sorted_result = {
      future: meals.where("date > ?", Time.now),
      past: meals.where("date < ?", Time.now)
    }

    return sorted_result
  end

  def get_sorted_events
    events = self.events
    sorted_result = {
      future: events.where("date > ?", Time.now),
      past: events.where("date < ?", Time.now)
    }

    return sorted_result
  end
end
