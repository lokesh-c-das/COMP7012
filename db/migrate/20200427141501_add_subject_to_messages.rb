class AddSubjectToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :subject, :string
  end
end
