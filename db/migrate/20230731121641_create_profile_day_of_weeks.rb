class CreateProfileDayOfWeeks < ActiveRecord::Migration[7.0]
  def change
    create_table :profile_day_of_weeks do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :day_of_week, null: false, foreign_key: true

      t.timestamps
    end
  end
end
