class Api::CommentsController < ApplicationController

    def create
        set_commentable
        @comment = @commentable.comments.create(:user_id => params[:comment][:user_id], :body => params[:comment][:body])
        if @comment.save
            set_comment_notification

            render_post
        else
            render json: @comment.errors.full_messages, status: 422
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.notification.destroy
        @comment.destroy
        @commentable = Object.const_get(@comment.commentable_type).find(@comment.commentable_id)
        render_post
    end

    # def update
    #     @comment = Comment.find(params[:id])
    #     if @comment.update(comment_params)
    #         render :show
    #     else
    #         render json: @comment.errors.full_messages
    #     end
    # end


    private 

    def set_commentable
        @commentable = Object.const_get(params[:comment][:commentable_type]).find(params[:comment][:commentable_id])
    end

    def render_post
        @post = @commentable
        while @post.class.name != "Post"
            @post = Object.const_get(@post.commentable_type).find(@post.commentable_id)
        end
        render "api/posts/show"
    end

    def set_comment_notification
        if params[:comment][:user_id] != @commentable.user.id
            Notification.create!(recipient: @commentable.user, actor: User.find(params[:comment][:user_id]), action: "commented", notifiable: @comment)
        end
    end
end
