class Registration < ApplicationRecord
    belongs_to :class_period
    belongs_to :student
end
