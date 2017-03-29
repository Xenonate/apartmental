class CreateSearchResults < ActiveRecord::Migration
  def change
    create_table :search_results do |t|
      t.integer :search_id
      t.integer :address_id
      t.string :pindex
      t.string :pindex_price
      t.string :pindex_walkscore
      t.string :pindex_commutescore
      t.string :pindex_crimerate
      t.string :price_weight
      t.string :commute_weight
      t.string :walkscore_weight
      t.string :crime_weight
    end
  end
end
