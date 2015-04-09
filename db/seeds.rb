


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

radius = 50

while radius < 800
	f = Foursquare.new(radius)
  f.make_restaurants
  radius += 50
end

# user_info = [
#   {firstname: "Ian", lastname: "Candy", email: "ian@ian.com" },
#   {firstname: "Deniz", lastname: "Unat", email: "deniz@unat.com" }, 
#   {firstname: "Lara", lastname: "Skholoff", email: "lara@lara.com" }, 
#   {firstname: "Jeremy", lastname: "Sklarsky", email: "jeremyrules@ian.com" }, 
#   {firstname: "Rachel", lastname: "Nackman", email: "nackman@nackman.com" } 
# ]

# users = User.create(user_info)