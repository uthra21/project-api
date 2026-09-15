class Api::V1::BaseController < Api::BaseController
    def set_studio
        @studio = Studio.find_by!(slug:params[:studio_slug])
    end
    def set_student
        @student = @studio.students.find(params[:student_id])
    end
    def set_lesson
        @lesson = @studio.lessons.find(params[:lesson_id])
    end
end