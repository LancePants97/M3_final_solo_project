class Api::V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
      if @user.save
        render json: UserSerializer.user_json(@user), status: 201
      else
        render json: { "errors": @user.errors.full_messages }, status: 400
      end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end