class Api::V1::SessionsController < ApplicationController
  def create
    email = params[:email].downcase
    @user = User.find_by(email: email)

    if @user && @user.authenticate(params[:password])
      render json: LoginSerializer.login_json(@user), status: 200
    else
      render json: { "errors": "Your credentials are bad" }, status: 400
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end