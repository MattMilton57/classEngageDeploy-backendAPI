class AddMaxSizeToClassPeriods < ActiveRecord::Migration[6.0]
  def change
    add_column :class_periods, :max, :int
  end
end
