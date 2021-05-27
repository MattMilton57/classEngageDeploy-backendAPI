class AddUserToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :user, :int
  end
end
