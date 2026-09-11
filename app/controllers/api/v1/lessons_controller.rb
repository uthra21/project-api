class Api::V1::LessonsController < Api::V1::BaseController
    before_action :set_studio, only:[:index,:show,:create,:update,:cancel,:reinstate]
    before_action :set_lesson, only:[:show,:update,:cancel,:reinstate]
    def index
        lessons = @studio.lessons
        if params[:status].present?
            lessons = lessons.status(params[:status])
        end
        if params[:instructor_id].present?
            lessons = lessons.instructor_id(Integer(params[:instructor_id]))
        end
        if params[:unassigned].present?
            if params[:unassigned] == "true"
                lessons = lessons.unassigned
            end
        end
        if params[:starts_after].present?
            lessons = lessons.starts_after(Time.parse(params[:starts_after]))
        end
        if params[:has_space].present?
            lessons = lessons.has_space
        end
        render json: lessons, status: :ok  
    end
    def show
        render json: @lesson.as_json(
           only: [:name, :start_time]
        )
    end
    def create
        lesson_params = params.require(:lesson).permit(
            :name, :start_time,:capacity, :instructor_id
        )
        new_lesson = Lesson.new(lesson_params)
        new_lesson.studio = @studio
        if new_lesson.save
            render json: new_lesson, status: :created
        else
            render json: {error:new_lesson.errors}, status: :unprocessable_entity
        end
    end
    def update
        lesson_params = params.require(:lesson).permit(
            :name, :start_time,:capacity, :instructor_id
        )
        if @lesson.update(lesson_params)
            render json: @lesson, status: :ok
        else
            render json: {error: @lesson.errors}, status: :unprocessable_entity
        end
    end
    def cancel
        if @lesson.update(status:"cancelled")
            render json: @lesson, status: :ok
        else
            render json: {error: @lesson.errors}, status: :unprocessable_entity
        end
    end
    def reinstate
        if @lesson.update(status:"available")
            render json: @lesson, status: :ok
        else
            render json: {error: @lesson.errors}, status: :unprocessable_entity
        end
    end
end