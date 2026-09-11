class Api::V1::BookingsController < Api::V1::BaseController
    before_action :set_studio
    before_action :set_lesson
    def index
        bookings = @lesson.bookings
        render json: bookings, status: :ok
    end
    def create
        bookings_params = params.require(:booking).permit(:student_id)
        booking = Booking.new(booking_params)
        booking.lesson = @lesson
        if booking.save
            render json: booking, status: :created
        else
            render json: {error:booking.errors}, status: :unprocessable_entity
        end
    end
end