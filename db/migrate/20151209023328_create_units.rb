class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.references :user_building, index: true, foreign_key: true
      t.integer :unit_number
      t.integer :sqfootage
      t.integer :number_bedrooms
      t.integer :number_bathrooms
      t.integer :number_rooms
      t.integer :number_occupants

      t.timestamps null: false
    end
  end
end
