class CreateUserTips < ActiveRecord::Migration
  def change
    create_table :user_tips do |t|
      t.references :user, index: true, foreign_key: true
      t.references :tip, index: true, foreign_key: true
      t.string :result

      t.timestamps null: false
    end
  end
end
