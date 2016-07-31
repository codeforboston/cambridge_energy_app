class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :filename
      t.integer :user_id
      t.jsonb :jdoc
      t.text :xml

      t.timestamps
    end
  end
end
