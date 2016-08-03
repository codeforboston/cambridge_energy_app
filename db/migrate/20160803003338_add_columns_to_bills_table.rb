class AddColumnsToBillsTable < ActiveRecord::Migration
  def change
    add_column :bills, :bill_days, :integer
    add_column :bills, :amount, :decimal
    add_column :bills, :upload_id, :integer
  end
end
