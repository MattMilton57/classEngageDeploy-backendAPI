class AddUserToAssessments < ActiveRecord::Migration[6.0]
  def change
    add_column :assessments, :user_id, :int
  end
end
