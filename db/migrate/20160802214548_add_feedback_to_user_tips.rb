class AddFeedbackToUserTips < ActiveRecord::Migration
  def change
    add_column :user_tips, :feedback, :string
  end
end
