class ApplicationController < ActionController::API
  def validate_api_key
    if !params[:api_key].present? || params[:api_key].length == 0
      render json: { "error": 'Missing API Key' }, status: 401
    else
      api_key = params[:api_key]
      unless User.exists?(api_key: api_key)
        render json: { "error": 'Unauthorized API Key Request' }, status: 401
      end
    end
  end
end
