class AuthUserController < ApplicationController
  skip_before_action :authorized, only: [:create]
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  def create
    @user = User.find_by(username: user_params[:username])
    if @user&.authenticate(user_params[:password])
      @token = encode_token(user_id: @user.id)
      cookies["token"] = @token
      render json: @user, serializer: UserSerializer, status: :created
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :password)
  end
end
