class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.time :delivery_date, null: false
      t.integer :status, null: false, default: 0
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
