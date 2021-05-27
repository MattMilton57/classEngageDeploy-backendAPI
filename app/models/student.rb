class Student < ApplicationRecord
    has_many :registrations
    has_many :class_periods, through: :registrations
    has_many :assessments
end
