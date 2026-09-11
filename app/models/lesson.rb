class Lesson < ApplicationRecord
  include Sluggable
  belongs_to :studio
  belongs_to :instructor, optional:true
  validates :slug, uniqueness:{scope: :studio_id}
  validates :code, uniqueness:{scope: :studio_id}
  validates :status, inclusion:{in:["available","cancelled"]}
  has_many :bookings
  has_many :students, through: :bookings
  after_create :generate_code
  before_save :add_cancellation_time
  after_commit :notify_cancellation, on:[:create,:update]
  validate :belongs_to_the_same_studio
  scope :status, -> (status) {where(status:status)}
  scope :instructor_id, -> (id) {where(instructor_id:id)}
  scope :unassigned, -> {where(instructor_id:nil)}
  scope :starts_after, -> (time) {where("start_time >= ?",time)}
  scope :has_space,-> {where("capacity > SELECT COUNT(*) FROM bookings WHERE bookings.lesson_id = lessons.id AND bookings.status != 'cancelled'")}
  def belongs_to_the_same_studio
    return unless instructor.nil?
    unless instructor.studio_id == studio_id
      errors.add(:instructor,"must be from the same studio")
    end
  end
  def generate_code
    update_column(:code,"#{studio.name}-#{self.id}")
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
