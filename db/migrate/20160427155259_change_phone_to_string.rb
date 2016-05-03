class ChangePhoneToString < ActiveRecord::Migration
  def up
    change_column :users, :phone, :string
  end

  def down
    # 10-digit phone numbers and empty strings cannot be converted into integers.
    raise ActiveRecord::IrreversibleMigration, "Can't convert phone numbers to integers"
  end
end
