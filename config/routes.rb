Rails.application.routes.draw do
  devise_for :users
  resources :profiles, only: [:index, :show, :edit] do
    resources :events
  end
  resources :notifications, only: [:show, :update] do
    get 'dismissed' , to: 'notifications#dismissed'
  end

  root to: 'pages#home'

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

end


