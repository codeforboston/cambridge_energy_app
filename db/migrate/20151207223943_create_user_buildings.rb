class CreateUserBuildings < ActiveRecord::Migration
  def change
    create_table :user_buildings do |t|
      t.string :address
      t.float :lat
      t.float :lon

      t.timestamps null: false
    end
  end
end
