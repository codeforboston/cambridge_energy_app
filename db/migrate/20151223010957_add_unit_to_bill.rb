class AddUnitToBill < ActiveRecord::Migration
  def change
    add_reference :bills, :unit, index: true, foreign_key: true
  end
end
