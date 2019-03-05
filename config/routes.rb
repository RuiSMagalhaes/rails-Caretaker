Rails.application.routes.draw do
  devise_for :users
  resources :profiles, only: [:index, :show, :edit] do
    resources :events
  end
  resources :notifications, only: [:show, :destroy]
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


