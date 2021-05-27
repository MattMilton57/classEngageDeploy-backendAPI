class CreateClassPeriods < ActiveRecord::Migration[6.0]
  def change
    create_table :class_periods do |t|
      t.string :subject
      t.string :period
      t.integer :level
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
