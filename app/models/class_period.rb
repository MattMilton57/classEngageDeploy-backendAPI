class ClassPeriod < ApplicationRecord
    belongs_to :user
    has_many :assessments
    has_many :registrations
    has_many :students, through: :registrations
end
