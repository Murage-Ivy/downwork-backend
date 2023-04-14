class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  rescue_from ActiveRecord::InvalidRecord, with: :render_unprocessable_entity_response

  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  def create
    @user = User.create!(user_params)
    @token = encode_token(user_id: @user_id)
    cookies["token"] = @token
    render json: { user: UserSerializer.new(@user) }, status: :created
  end

  private

  def user_params
    params.permit(:username, :email, :image_url, :password, :password_confirmation)
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
