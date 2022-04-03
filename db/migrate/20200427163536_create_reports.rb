class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.string :user_id
      t.string :subject
      t.string :body

      t.timestamps
    end
  end
end
