class Studio < ApplicationRecord
    include Sluggable
    has_one :cancellation_policy
    has_many :lessons
    has_many :students
    has_many :instructors
    validates :slug, uniqueness:true
end
