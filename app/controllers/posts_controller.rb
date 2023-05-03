class PostsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_response_not_found
  wrap_parameters format: []

  def create
    byebug
    post = current_user.posts.create!(post_params)
    render json: post, status: :created
  end

  def index
    if (find_params[:category])
      posts = Post.where(category: find_params[:category])
    else
      posts = Post.all
    end
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

  def increment_likes
    post = find_post
    if Like.find_by(user_id: current_user.id, post_id: post.id)
      Like.find_by(user_id: current_user.id, post_id: post.id).destroy
      post.update!(likes: post.likes - 1)
    else
      Like.create(user_id: current_user.id, post_id: post.id)
      post.update!(likes: post.likes + 1)
    end

    render json: post, status: :ok
  end

  def destroy
    post = find_post
    post.destroy
    head :no_content
  end

  private

  def post_params
    params.permit(:title, :description, :image_url, :category, :likes)
  end

  def find_params
    params.permit(:category)
  end

  def find_post
    post = Post.find(params[:id])
  end

  def render_response_not_found
    render json: { error: "Post not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
