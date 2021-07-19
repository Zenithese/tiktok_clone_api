class Api::LikesController < ApplicationController
    
    def index
        @likes = Like.all
    end

    def create
        set_likeable
        @like = @likeable.likes.create(:user_id => params[:like][:user_id])
        if @like.save
            # set_like_notifications

            render_post
        else
            render json: @like.errors.full_messages, status: 422
        end
    end

    def destroy
        @like = Like.find(params[:id])
        # @like.notification.destroy if @like.notification
        @like.destroy
        @likeable = Object.const_get(@like.likeable_type).find(@like.likeable_id)
        render_post
    end

    # private

    def set_likeable
        @likeable = Object.const_get(params[:like][:likeable_type]).find(params[:like][:likeable_id])
    end

    def render_post
        @post = @likeable
        while @post.class.name != "Post"
            @post = @post.class.name == "Like" ?
                Object.const_get(@post.likeable_type).find(@post.likeable_id)
                : Object.const_get(@post.commentable_type).find(@post.commentable_id)
        end
        render "api/posts/show"
    end

end