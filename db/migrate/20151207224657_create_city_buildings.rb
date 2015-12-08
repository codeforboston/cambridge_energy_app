class CreateCityBuildings < ActiveRecord::Migration
  def change    
    create_table :city_buildings do |t|
      t.belongs_to :landlord, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
