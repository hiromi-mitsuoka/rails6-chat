Rails.application.routes.draw do
  # 全体トークの無限スクロール対応用のルーティング
  get '/show_additionally', to: 'rooms#show_additionally'
  mount ActionCable.server => '/cable'
  resources :messages, only: :create
  get 'rooms/show'
  devise_for :users
  root to: "home#index"
end
