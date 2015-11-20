class AddColumnToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :price, :string
    add_column :addresses, :walkscore, :string
  end
end
