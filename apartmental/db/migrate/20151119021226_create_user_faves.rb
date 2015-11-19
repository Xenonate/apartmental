class CreateUserFaves < ActiveRecord::Migration
  def change
    create_table :user_faves do |t|
      t.integer :user_id
      t.integer :fave_id

      t.timestamps null: false
    end
  end
end
