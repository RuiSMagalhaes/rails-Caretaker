Rails.application.routes.draw do
  devise_for :users
  resources :profiles, only: [:home, :show, :edit] do
    resources :events
  end
  resources :notifications, only: [:show, :dismissed]
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
