class Api::CommentsController < ApplicationController

    def index
        @comments = Comment.all.includes(:comments, :likes)
    end

    def create
        @comment = Comment.new(comment_params)
        if @comment.save
            render :show
        else
            render json: @comment.errors.full_messages, status: 422
        end
    end

    def show
        @comment = Comment.find(params[:id])
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        render :show
    end

    def update
        @comment = Comment.find(params[:id])
        if @comment.update(comment_params)
            render :show
        else
            render json: @comment.errors.full_messages
        end
    end


    private 

    # def comment_params
    #     params.require(:comment).permit()
    # end
end
