class ApplicationController < ActionController::API
  before_action :authorized
  include ActionController::Cookies

  def encode_token(payload)
    @token = JWT.encode(payload, "my_s3cret_k3y")
  end

  def auth_cookies
    cookies["token"]
  end

  def decode_token
    if auth_cookies
      token = auth_cookies
      begin
        JWT.decode(token, "my_s3cret_k3y", true, algorithm: "HS256")
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

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end

