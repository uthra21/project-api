class Instructor < ApplicationRecord
    belongs_to :studio
    has_many :lessons
end
