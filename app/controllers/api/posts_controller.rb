require 'open-uri'

class Api::PostsController < ApplicationController
    
    def index
        current_user
        @posts = Post.all.includes(:user, :likes, comments: :likes)
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            file = Tempfile.new("")
            file.binmode
            file << Base64.decode64(params[:post][:base64])
            file.rewind
            @post.post_video.attach(io: file, filename: "new video")

            thumbnail = Tempfile.new("")
            thumbnail.binmode
            thumbnail << Base64.decode64(params[:post][:thumbnail])
            thumbnail.rewind
            @post.thumbnail.attach(io: thumbnail, filename: `new thumbnail`)

            render :show
        else
            render json: @book.errors.full_messages, status: 422
        end
    end

    def show
        @post = Post.find(params[:id])
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        render :show
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            render :show
        else
            render json: @book.errors.full_messages
        end
    end


    private 

    def post_params
        params.require(:post).permit(:user_id, :description, :video_uri)
    end
end
