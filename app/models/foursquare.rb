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
      # binding.pry
      restaurant = Restaurant.find_or_create_by(foursquare_id: restaurant_hash["id"])
      restaurant.name = restaurant_hash["name"]
      restaurant.lat = restaurant_hash["location"]["lat"]
      restaurant.lng = restaurant_hash["location"]["lng"]
      restaurant.postalcode = restaurant_hash["location"]["postalCode"]
      restaurant.address = restaurant_hash["location"]["formattedAddress"]
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

  

  # {"id"=>"53e929d5498e60742357fb87", "name"=>"Dig Inn Seasonal Market", "contact"=>{"phone"=>"2125457867", "formattedPhone"=>"(212) 545-7867", "twitter"=>"diginn", "facebook"=>"158613407523269", "facebookUsername"=>"diginnmarket", "facebookName"=>"Dig Inn Seasonal Market"}, "location"=>{"address"=>"80 Broad St", "crossStreet"=>"Stone & Marketfield", "lat"=>40.70435755218158, "lng"=>-74.01154445303536, "distance"=>231, "postalCode"=>"10004", "cc"=>"US", "city"=>"New York", "state"=>"NY", "country"=>"United States", "formattedAddress"=>["80 Broad St (Stone & Marketfield)", "New York, NY 10004", "United States"]}, "categories"=>[{"id"=>"4bf58dd8d48988d14e941735", "name"=>"American Restaurant", "pluralName"=>"American Restaurants", "shortName"=>"American", "icon"=>{"prefix"=>"https://ss3.4sqi.net/img/categories_v2/food/default_", "suffix"=>".png"}, "primary"=>true}], "verified"=>true, "stats"=>{"checkinsCount"=>746, "usersCount"=>307, "tipCount"=>5}, "url"=>"http://diginn.com", "specials"=>{"count"=>0, "items"=>[]}, "hereNow"=>{"count"=>2, "summary"=>"2 people are checked in here", "groups"=>[{"type"=>"others", "name"=>"Other people here", "count"=>2, "items"=>[]}]}, "referralId"=>"v-1428431101"}

end
