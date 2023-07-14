class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.time :dinner_time, null: false
      t.time :bedtime, null: false
      t.integer :holiday_of_week, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
