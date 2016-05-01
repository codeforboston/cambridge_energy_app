class ChangePhoneToString < ActiveRecord::Migration
  def up
    change_column :users, :phone, :string
  end

  def down
    change_column :users, :phone, 'integer USING CAST(phone AS integer)'
  end
end
