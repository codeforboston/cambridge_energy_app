class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email
      t.integer :inviter_id
      t.integer :receiver_id
      t.integer :sender_id
      t.string :token

      t.timestamps null: false
    end
  end
end
