class ApplicationController < ActionController::API
  def encode_token(poyload)
    @token = JWT.encode(payload, ENV["my_s3cr3t"])
  end

  def auth_header
    request.headers["Authorization"]
  end

  def decode_token
  end

  def current_user
  end

  def logged_in?
  end
end
