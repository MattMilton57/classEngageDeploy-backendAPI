class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :students, :user, :user_id
  end
end
