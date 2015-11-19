class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street_number
      t.string :street_name
      t.string :apt_number
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :lat
      t.string :long

      t.timestamp null: false
    end
  end
end
