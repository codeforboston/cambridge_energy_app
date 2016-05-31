class AddTipNumToUser < ActiveRecord::Migration
  def change
    add_column :users, :tipnum, :integer
  end
end
