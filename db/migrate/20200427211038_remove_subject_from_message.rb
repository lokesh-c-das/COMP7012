class RemoveSubjectFromMessage < ActiveRecord::Migration[6.0]
  def change

    remove_column :messages, :subject, :string
  end
end
