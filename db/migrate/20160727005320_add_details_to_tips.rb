class AddDetailsToTips < ActiveRecord::Migration
  def change
    add_column :tips, :details, :string
  end
end
