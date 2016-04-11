class AddMssgToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :mssg, :string
  end
end
