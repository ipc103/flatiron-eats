class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :foursquare_id
      t.string :name
      t.float :lat
      t.float :lng
      t.string :postalcode
      t.string :address
      t.string :phone
      t.string :menu
      t.timestamps null: false
    end
  end
end
