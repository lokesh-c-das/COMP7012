class AddAuthorityToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :authority, :boolean
  end
end
