class StudioBooking::LessonsController < ApplicationController
    def show
        byebug
        render json: "ok", status: :ok
    end
end