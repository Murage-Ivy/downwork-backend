class CommentsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_response_not_found

  def index
    comments = Comment.all
    render json: comments
  end

  def show
    comment = find_comment
    render json: comment
  end

  def create
    comment = Comment.create!(comment_params)
    render json: comment, status: :created
  end

  def update
    comment = find_comment
    comment.update!(comment_params)
    render json: comment, status: :ok
  end

  def destroy
    comment = find_comment
    comment.destroy
    head :no_content
  end

  private

  def comment_params
    params.permit(:content, :user_id, :post_id)
  end

  def find_comment
    comment = Comment.find(params[:id])
  end

  def render_response_not_found
    render json: { error: "Comment not found" }, status: :not_found
  end
end
