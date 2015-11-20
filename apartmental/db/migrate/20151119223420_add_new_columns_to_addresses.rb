class AddNewColumnsToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :url, :string
    add_column :addresses, :neighborhood, :string
    add_column :addresses, :built, :string
  end
end
