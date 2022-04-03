class RemoveConversationIdFromReport < ActiveRecord::Migration[6.0]
  def change

    remove_column :reports, :conversation_id, :string
  end
end
