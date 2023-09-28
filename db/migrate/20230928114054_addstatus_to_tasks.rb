class AddstatusToTasks < ActiveRecord::Migration[7.0]
  def up
    add_column :tasks, :status, :integer, default: 0, null: false
  end

  def down
    remove_column :tasks, :status, :integer, default: 0
  end
end
