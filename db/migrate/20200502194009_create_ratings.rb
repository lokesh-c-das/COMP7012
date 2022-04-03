class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.integer :seller_id
      t.integer :buyer_id

      t.timestamps
    end
    add_foreign_key :ratings, :users, column: :seller_id, on_delete: :cascade
    add_foreign_key :ratings, :users, column: :buyer_id, on_delete: :cascade
  end
end
