class AddLineIdIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, :line_id
    add_index :users, :line_id, unique: true
  end
end
