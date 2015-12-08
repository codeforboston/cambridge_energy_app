class CreateUsers < ActiveRecord::Migration
  def change

    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_address
      t.integer :phone
      t.string :email
      t.string :password
      t.belongs_to :unit, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
