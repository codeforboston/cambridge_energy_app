class ChangeIntegerLimitForPhoneNumbers < ActiveRecord::Migration
  def change
    change_column :users, :phone, :integer, limit: 8
  end
end
