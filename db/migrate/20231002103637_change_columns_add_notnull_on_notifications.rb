class ChangeColumnsAddNotnullOnNotifications < ActiveRecord::Migration[7.0]
  def up
    change_column_null :notifications, :task_id, false
    change_column_null :notifications, :user_id, false
  end

  def down
    change_column_null :notifications, :task_id, true
    change_column_null :notifications, :user_id, true
  end
end
