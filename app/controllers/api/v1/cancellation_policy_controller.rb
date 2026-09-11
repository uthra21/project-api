class Api::V1::CancellationPolicy < Api::V1::BaseController
    before_action :set_studio
    def index
        policy = @studio.cancellation_policy
        render json: policy, status: :ok
    end
end