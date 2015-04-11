require 'open-uri'
class Foursquare

  attr_accessor :radius

  def initialize(radius)
    @radius = radius
  end

  def url
    key = ENV["foursquare_key"]
    secret= ENV["foursquare_secret"]
    version = "20140406"
    url = "https://api.foursquare.com/v2/venues/search?ll=40.705329,%20-74.013970&radius=#{@radius}&categoryId=%204d4b7105d754a06374d81259&limit=100&client_id=#{key}&client_secret=#{secret}&v=#{version}"
  end

  def get_json
    data = open(self.url).read
    JSON.parse(data)
  end

  def get_restaurants
    self.get_json["response"]["venues"]
  end

  def make_restaurants
    get_restaurants.each do |restaurant_hash|
      restaurant = Restaurant.find_or_create_by(foursquare_id: restaurant_hash["id"])
      restaurant.name = restaurant_hash["name"]
      restaurant.lat = restaurant_hash["location"]["lat"]
      restaurant.lng = restaurant_hash["location"]["lng"]
      restaurant.address_line1 = restaurant_hash["location"]["formattedAddress"][0]
      restaurant.address_line2 = restaurant_hash["location"]["formattedAddress"][1]
      restaurant.postalcode = restaurant_hash["location"]["postalCode"]
      restaurant.phone = restaurant_hash["contact"]["formattedPhone"]
      restaurant.menu = restaurant_hash["menu"]["url"] if restaurant_hash["menu"]
      restaurant_hash["categories"].each do |category_hash|
        category = Category.find_or_create_by(name: category_hash["shortName"])
        category.restaurants.push(restaurant)
        category.save
      end
      restaurant.save
    end
  end
end
