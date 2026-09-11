class Instructor < ApplicationRecord
    belongs_to :studio
    has_many :lessons
    validates :email, uniqueness: {scope: :studio_id}
end
