class Lesson < ApplicationRecord
  include Sluggable
  belongs_to :studio
  belongs_to :instructor, optional:true
  validate :slug, uniqueness:{scope: :studio_id}
  validate :code, uniqueness:{scope: :studio_id}
  has_many :bookings
  has_many :students, through: :bookings
  after_create :generate_code
  before_save :add_cancellation_time
  after_commit :notify_cancellation, on:[:create,:update]
  def generate_code
    update_column(:code,"#{self.name}-#{self.id}")
  end
  def add_cancellation_time
    if self.status == "cancelled"
      self.cancelled_at = Time.now
    else
      self.cancelled_at = nil
    end
  end
  def notify_cancellation
    return unless self.status == "cancelled"
    return unless saved_change_to_status?
    ExternalNotifier.notify(self.code)
  end
end
