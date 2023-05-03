class LikesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_response_not_found
    wrap_parameters format: []
    
    def create
        like = current_user.likes.create!(like_params)
        render json: like, status: :created
    end
    
    def index
        if (find_params[:post_id])
        likes = Like.where(post_id: find_params[:post_id])
        else
        likes = Like.all
        end
        render json: likes, status: :ok
    end
    
    def show
        like = find_like
        render json: like, status: :ok
    end
    
    def update
        like = find_like
        like.update!(like_params)
        render json: like, status: :ok
    end
    
    def destroy
        like = find_like
        like.destroy
        head :no_content
    end
    
    private
    
    def like_params
        params.permit(:post_id)
    end
    
    def find_params
        params.permit(:post_id)
    end
    
    def find_like
        like = Like.find(params[:id])
    end
    
    def render_response_not_found
        render json: { error: "Like not found" }, status: :not_found
    end
end
