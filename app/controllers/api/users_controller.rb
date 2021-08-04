require 'base64'
require 'open-uri'

class Api::UsersController < ApplicationController
  def create
    @user = User.new(user_params).includes(:posts, :followings, :followers)

    if @user.save
      login(@user)
      render "api/users/show"
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  def update
    @user = User.find_by(id: params[:user][:id], session_token: params[:user][:token])
    if @user
      file = Tempfile.new("")
      file.binmode
      file << Base64.decode64(params[:user][:base64])
      file.rewind
      @user.user_image.attach(io: file, filename: params[:user][:name])
      render "api/users/show"
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :token)
  end
end
