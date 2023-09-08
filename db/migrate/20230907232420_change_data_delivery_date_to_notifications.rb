class ChangeDataDeliveryDateToNotifications < ActiveRecord::Migration[7.0]
  def up
    remove_column :notifications, :delivery_date, :time
    add_column :notifications, :delivery_date, :datetime
  end

  def down
    remove_column :notifications, :delivery_date, :datetime
    add_column :notifications, :delivery_date, :time
  end
end
