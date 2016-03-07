class AddInviterToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :inviter, :integer
  end
end
