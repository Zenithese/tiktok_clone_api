Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    resource :user, only: [:create]
    resource :session, only: [:create, :destroy, :show]
    resources :posts, only: [:index, :create, :show, :update, :destroy]
  end
end