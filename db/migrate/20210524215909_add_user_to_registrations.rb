class AddUserToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :user_id, :int
  end
end
