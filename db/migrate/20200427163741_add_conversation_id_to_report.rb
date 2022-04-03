class AddConversationIdToReport < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :conversation_id, :string
  end
end
