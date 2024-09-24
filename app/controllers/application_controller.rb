class ApplicationController < ActionController::API
  def validate_api_key
    api_key = params[:api_key]
    user_key = User.find_by(api_key: api_key)

    if api_key != user_key
      render json: { "error": 'Unauthorized API Key Request' }, status: 401
    end
  end
end
