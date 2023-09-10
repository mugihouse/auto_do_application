class ChangeDataBedtimeToProfiles < ActiveRecord::Migration[7.0]
  def up
    remove_column :profiles, :bedtime, :time
    add_column :profiles, :bedtime, :datetime
  end

  def down
  remove_column :profiles, :bedtime, :datetime
  add_column :profiles, :bedtime, :time
  end
end
