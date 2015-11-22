class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :image_url
      t.string :street_number
      t.string :street_name
      t.string :street_type
      t.string :apt_number
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :price
      t.string :bedrooms
      t.string :lat
      t.string :long
      t.string :walkscore
      t.string :built
      t.string :listing_url
      t.string :neighborhood
      t.string :crime_rate

      t.timestamp null: false
    end
  end
end
