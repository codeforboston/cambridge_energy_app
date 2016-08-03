class RenameCostToUsage < ActiveRecord::Migration
  def up
    change_table :bills do |t|
      t.rename :amount, :usage
    end
  end
  def down
    change_table :bills do |t|
      t.rename :usage, :amount
    end
  end
end
