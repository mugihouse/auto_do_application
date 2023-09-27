class AddRolesToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :role, :integer, default: 0
    User.update_all(role: 0)
    change_column_null :users, :role, false
  end

  def down
    remove_column :users, :role, :integer, null: false
  end
end
