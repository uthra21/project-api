class Api::V1::StudentsController < Api::V1::BaseController
    before_action :set_studio, only:[:index,:show,:lessons]
    before_action :set_student, only:[:show,:lessons]
    def index
        students = @studio.students
        render json: students, status: :ok
    end
    def show
        render json: @student.as_json(
            only: [:name,:email]
        ), status: :ok
    end
    def lessons
        lessons_booked = @student.lessons
        render json: lessons_booked, status: :ok
    end
end