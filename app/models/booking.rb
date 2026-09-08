class Booking < ApplicationRecord
  belongs_to :lesson
  belongs_to :student
  before_save :time_of_booking
  validate :student_id, uniqueness:{scope: :lesson_id}
  validate :status, inclusion: {in:["attended","no-show","cancelled"]}
  before_create :validate_capacity
  scope :cancelled, -> {where(status:"cancelled")}
  def time_of_booking
    update_column(:booking_time,Time.now)
  end
  def validate_capacity
    if (lesson.capacity - (self.last.id - count(self.cancelled))) == 0
      errors.add("Lesson fully booked, try again next time or try other lessons")
    end
  end
end
