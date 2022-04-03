class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :phone_no, :string
    add_column :users, :uid, :string
    add_column :users, :rating, :float, default: 0
  end
end
