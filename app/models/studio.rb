class Studio < ApplicationRecord
    include Sluggable
    has_many :lessons
    has_many :students
    has_many :instructors
    validates :slug, unique:true
end
