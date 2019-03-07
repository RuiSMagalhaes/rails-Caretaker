Rails.application.routes.draw do
  devise_for :users
  resources :profiles, only: [:index, :show, :edit] do
    resources :events
  end

  # to have a index events page (with all events caretaker and all patients)
  get '/events', to: 'events#schedule'

  resources :notifications, only: [:show, :update, :destroy]

  root to: 'pages#home'

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

end
