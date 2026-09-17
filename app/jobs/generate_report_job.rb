require "csv"
require "fileutils"

class GenerateReportJob < ApplicationJob
  queue_as :default

  def perform(report_id)
    report = Report.find(report_id)
    studio = report.studio

    begin
      report_directory = Rails.root.join("tmp", "reports")
      FileUtils.mkdir_p(report_directory)

      file_path = report_directory.join("studio_#{studio.id}_report_#{report.id}.csv")

      CSV.open(file_path, "w", write_headers: true, headers: [
        "Student",
        "Lesson",
        "Instructor",
        "Starts At",
        "Booking Status"
      ]) do |csv|

        studio.lessons.includes(:instructor, bookings: :student).find_each do |lesson|
          lesson.bookings.each do |booking|
            csv << [
              booking.student.name,
              lesson.name,
              lesson.instructor.name,
              lesson.start_time,
              booking.status
            ]
          end
        end
      end

      report.file.attach(
        io: File.open(file_path),
        filename: "studio_#{studio.id}_report_#{report.id}.csv",
        content_type: "text/csv"
      )
      report.update!(status: "completed")

      puts "Report generated: #{file_path}"

    rescue StandardError
      report.update!(status: "failed")
      raise
    end
  end
end