class AddBedroomToAddresses < ActiveRecord::Migration
  def change
  add_column :addresses, :bedrooms, :string
  end
end
