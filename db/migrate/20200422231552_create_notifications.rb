class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.integer :identifier
      t.references :notified_by, index: true
      t.integer :notice_type
      t.boolean :read, default: false

      t.timestamps
    end
    add_foreign_key :notifications, :users, column: :notified_by_id, on_delete: :cascade

  end
end
