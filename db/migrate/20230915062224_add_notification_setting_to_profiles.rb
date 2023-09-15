class AddNotificationSettingToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :notification_setting, :boolean , default: true, null: false
  end
end
