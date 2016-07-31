class AddColumnsToBills < ActiveRecord::Migration
  def change
    add_column :bills, :bill_days, :integer
    add_column :bills, :usage, :integer
    add_column :bills, :upload_id, :integer
  end
end
