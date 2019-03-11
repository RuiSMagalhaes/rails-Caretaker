Rails.application.routes.draw do
  devise_for :users
  resources :profiles, only: [:index, :show] do
    resources :events
    resources :notifications, only: [:index, :show, :update, :destroy]
    get '/relations/new_caretaker', to: 'relations#new_caretaker', as: 'new_caretaker'
    post '/relations/new_caretaker', to: 'relations#create_caretaker', as: 'create_caretaker'
    get '/relations/new_patient', to: 'relations#new_patient', as: 'new_patient'
    post '/relations/new_patient', to: 'relations#create_patient', as: 'create_patient'
  end

  # to have a index events page (with all events caretaker and all patients)
  get '/events', to: 'events#full_index', as: "events"
  get '/notifications', to: 'notifications#full_index', as: "notifications"

  root to: 'pages#home'

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

end
