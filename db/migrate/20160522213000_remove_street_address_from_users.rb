class RemoveStreetAddressFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :street_address
  end
end
