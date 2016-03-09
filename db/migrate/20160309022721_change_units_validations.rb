class ChangeUnitsValidations < ActiveRecord::Migration
  def up
    change_column :units, :number_occupants, :integer, null: false
  end

  def down
    change_column :units, :number_occupants, :integer
  end
end
