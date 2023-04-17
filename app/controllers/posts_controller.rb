class PostsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_response_not_found

  def create
    post = Post.create!(post_params)
    render json: post, status: :created
  end

  def index
    posts = Post.all
    render json: posts, status: :ok
  end

  def show
    post = find_post
    render json: post, status: :ok
  end

  def update
    post = find_post
    post.update!(post_params)
    render json: post, status: :ok
  end

  def destroy
    post = find_post
    post.destroy
    head :no_content
  end

  private

  def post_params
    params.permit(:title, :description, :user_id, :image_url, :category, :likes)
  end

  def find_post
    post = Post.find(params[:id])
  end

  def render_response_not_found
    render json: { error: "Post not found" }, status: :not_found
  end
end
