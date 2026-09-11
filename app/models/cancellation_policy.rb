class CancellationPolicy < ApplicationRecord
  belongs_to :studio
  validates :studio_id, uniqueness:true, presence:true
end
