class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :text

      t.timestamps null: false
    end
  end
end
