class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action :authorized

  def encode_token(payload)
    # payload[:exp] = expiration
    @token = JWT.encode(payload, "my_s3cret_k3y")
  end

  def auth_cookies
    cookies["token"]
  end

  def decode_token
    if auth_header
      token = auth_header.split(" ")[1]
      begin
        JWT.decode(token, ENV["my_s3cr3t"], true, algorithm: "HS256")
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decode_token
      user_id = decode_token[0]["user_id"]
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { message: "Please log in" }, status: :unauthorized unless logged_in?
  end

  def render_unprocessable_entity_response
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
