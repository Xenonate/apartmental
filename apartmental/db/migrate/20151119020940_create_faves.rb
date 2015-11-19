class CreateFaves < ActiveRecord::Migration
  def change
    create_table :faves do |t|
      t.string :address

      t.timestamps null: false
    end
  end
end
