class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end
    add_foreign_key :conversations, :users, column: :sender_id, on_delete: :cascade
    add_foreign_key :conversations, :users, column: :recipient_id, on_delete: :cascade
  end
end
