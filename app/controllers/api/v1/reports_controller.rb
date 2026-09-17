class Api::V1::ReportsController < Api::V1::BaseController
    before_action :set_studio
    def create
        report = @studio.reports.create!(status: "processing")
        GenerateReportJob.perform_later(report.id)
        render json: {id: report.id, status: report.status}, status: :accepted
    end
    def download
        report = @studio.reports.find(params[:id])
        unless report.file.attached?
            render json: {error: "Report file not available"}, status: :not_found
            return
        end
        redirect_to rails_blob_path(report.file,disposition: "attachment")
    end
end