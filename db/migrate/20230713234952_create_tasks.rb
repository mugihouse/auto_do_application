class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :body
      t.integer :time_required, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
