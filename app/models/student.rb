class Student < ApplicationRecord
    belongs_to :studio
    has_many :bookings
    has_many :lessons, through: :bookings
end
