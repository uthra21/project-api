class Student < ApplicationRecord
    belongs_to :studio
    has_many :bookings
    has_many :lessons, through: :bookings
    validates :email, uniqueness: {scope: :studio_id}
end
