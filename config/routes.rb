Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    resource :user, only: [:create, :update]
    resources :sessions, only: [:create, :destroy, :show]
    resources :posts, only: [:index, :create, :show, :update, :destroy]
    resources :likes, only: [:index, :create, :destroy]
    resources :notifications, only: [:index, :update]
    resources :comments, only: [:create, :destroy]
    resources :hashtags, only: [:index, :create, :destroy]
    get 'validate_token' => 'sessions#validate_token'
  end
end
