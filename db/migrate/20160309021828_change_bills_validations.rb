class ChangeBillsValidations < ActiveRecord::Migration
  def up
    change_column :bills, :bill_received, :date, null: false
    change_column :bills, :amount, :integer, null: false
  end

  def down
    change_column :bills, :bill_received, :date
    change_column :bills, :amount, :integer
  end
end
