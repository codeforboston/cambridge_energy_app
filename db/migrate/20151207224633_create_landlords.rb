class CreateLandlords < ActiveRecord::Migration
  def change
    create_table :landlords do |t|
      t.string :first_name
      t.string :last_name
      t.string :mailing_address
      t.integer :phone
      t.string :email

      t.timestamps null: false
    end
  end
end
