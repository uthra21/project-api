class Report < ApplicationRecord
  belongs_to :studio
  has_one_attached :file
  validates :status, inclusion: {in:["processing","completed","failed"]}
end
