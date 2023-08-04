class RemoveHolidayOfWeekFromProfiles < ActiveRecord::Migration[7.0]
  def up
    remove_column :profiles, :holiday_of_week, :integer
  end

  def down
    add_column :profiles, :holiday_of_week, :integer, null: false
  end
end
