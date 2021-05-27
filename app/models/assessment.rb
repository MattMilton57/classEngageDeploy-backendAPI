class Assessment < ApplicationRecord
    belongs_to :student
    belongs_to :class_period
end
