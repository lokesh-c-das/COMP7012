class AddConversationToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :conversation, :integer
  end
end
