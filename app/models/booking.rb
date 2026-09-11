class Booking < ApplicationRecord
  belongs_to :lesson
  belongs_to :student
  before_save :time_of_booking
  validates :student_id, uniqueness:{scope: :lesson_id}
  validates :status, inclusion: {in:["attended","no-show","cancelled"]}
  validate :belongs_to_the_same_studio
  validate :validate_capacity, on: :create
  def time_of_booking
    self.booking_time = Time.now
  end
  def validate_capacity
    live_bookings = lesson.bookings.where.not(status:"cancelled").count
    if live_bookings >= lesson.capacity
      errors.add(:lesson,"is fully booked")
    end
  end
  def belongs_to_the_same_studio
    unless lesson.studio_id == student.studio_id
      errors.add(:studio,"should be the same for both the lessons and the studios")
    end
  end
end
