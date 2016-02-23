class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :receiver_id
      t.integer :sender_id

      t.timestamps null: false
    end
    add_index :invitations, :receiver_id
    add_index :invitations, :sender_id
    add_index :invitations, [:receiver_id, :sender_id], unique: true
  end
end
