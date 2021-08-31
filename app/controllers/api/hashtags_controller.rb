class Api::HashtagsController < ApplicationController

    def index
        @hashtags = Hashtag.all
    end

    def create
        @hashtag = Hashtag.new(hashtag_params)
        
        if @hashtag.save
            set_hashtag_notification

            render :show
        else
            render json: @hashtag.errors.full_messages, status: 422
        end
    end

    def destroy
        @hashtag = hashtag.find(params[:id])
        @hashtag.notifications.destroy_all
        @hashtag.destroy
        render :show
    end

    private

    def follow_params
        params.require(:hashtag).permit()
    end

end