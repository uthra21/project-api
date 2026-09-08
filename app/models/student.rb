class Student < ApplicationRecord
    belongs_to :studio
    has_many :bookings
    has_many :lessons, through: :bookings
    validate :belongs_to_the_same_studio
    def belongs_to_the_same_studio
        unless studio.id == studio_id
            errors.add(:studio,"must be the same studio")
        end
    end
end
