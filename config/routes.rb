Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  resources :messages, only: :create
  get 'rooms/show'
  devise_for :users
  root to: "home#index"
end
