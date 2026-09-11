class Api::BaseController < ApplicationController
    skip_forgery_protection
    before_action :authenticate!
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    rescue_from ActionController::ParameterMissing , with: :handle_missing_parameter

    API_KEY = "training-key"
    private
    def authenticate!
        headers = request.headers["X-Api-Key"]
        if headers != API_KEY
            render json: {error: "You don't have access"}, status: :unauthorized
        end
    end
    def handle_not_found
        render json: {error:"record not found"}, status: :not_founf
    end
    def handle_missing_parameter
        render json: {error: "Parameter missing/incorrect"}, status: :unprocessable_entity
    end
end