class Api::FollowsController < ApplicationController

    def index
        @follows = Follow.where(:user_id => params[:follow][:user_id])
    end

    def create
        @follow = Follow.new(follow_params)
        
        if @follow.save
            set_follow_notification

            render :show
        else
            render json: @follow.errors.full_messages, status: 422
        end
    end

    def destroy
        @follow = Follow.find(params[:id])
        @follow.notifications.destroy_all
        @follow.destroy
        render :show
    end

    private

    def follow_params
        params.require(:follow).permit(:user_id, :follow_id)
    end

    def set_follow_notification
        Notification.create!(recipient: @follow.follow, actor: User.find(params[:follow][:user_id]), action: "follows", notifiable: @follow)  
    end

end