class ChangeUnitNumberInUnits < ActiveRecord::Migration
  def up
    change_column :units, :unit_number, :string
  end

  def down
    change_column :units, :unit_number, :integer
  end
end
