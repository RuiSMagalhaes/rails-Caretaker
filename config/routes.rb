Rails.application.routes.draw do
  devise_for :users
  resources :profiles, only: [:index, :show, :edit] do
    resources :events
    get '/relations/new_caretaker', to: 'relations#new_caretaker', as: 'new_caretaker'
    post '/relations/new_caretaker', to: 'relations#create_caretaker', as: 'create_caretaker'
    get '/relations/new_patient', to: 'relations#new_patient', as: 'new_patient'
    post '/relations/new_patient', to: 'relations#create_patient', as: 'create_patient'
  end

  # to have a index events page (with all events caretaker and all patients)
  get '/events', to: 'events#schedule'

  resources :notifications, only: [:index, :show, :update, :destroy]

  root to: 'pages#home'

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

end
