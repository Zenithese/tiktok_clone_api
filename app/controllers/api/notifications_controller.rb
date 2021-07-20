class Api::NotificationsController < ApplicationController

    def index
        @notifications = Notification.where(recipient: User.find(params[:user_id])).includes(:notifiable).order(:created_at)
        # + Notification.where(recipient: current_user).read
    end

    def update
        @notification = Notification.find(params[:id])
        if @notification.update(:read_at => DateTime.now)
            render :show
        else
            render json: @notification.errors.full_messages, status: 422
        end
    end

end