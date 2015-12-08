class CreateUnits < ActiveRecord::Migration
  def change
    
    create_table :units do |t|
      t.integer :unit_number
      t.integer :sqfootage
      t.belongs_to :user_building, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
