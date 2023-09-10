class ChangeDataDinnerTimeToProfiles < ActiveRecord::Migration[7.0]
  def up
    remove_column :profiles, :dinner_time, :time
    add_column :profiles, :dinner_time, :datetime
  end

  def down
    remove_column :profiles, :dinner_time, :datetime
    add_column :profiles, :dinner_time, :time
  end
end
