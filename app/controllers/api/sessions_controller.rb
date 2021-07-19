class Api::SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      login(@user)
      render "api/users/show"
    else
      render json: ["Invalid username/password combination"], status: 401
    end
  end

  def destroy
    @user = User.find_by(session_token: params[:id])
    if @user
      logout(@user)
    end
    head 204
  end

  # private

  def validate_token
    @user = User.find_by(id: params[:id], session_token: params[:token])
    if @user
      render "api/users/show"
    else
      render json: ["User not authenticated"], status: 404
    end
  end
end
