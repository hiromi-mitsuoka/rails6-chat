Rails.application.routes.draw do
  # 全体トークの無限スクロール対応用のルーティング
  get '/dm_show_additionally', to: 'dm_rooms#show_additionally'
  get '/show_additionally', to: 'rooms#show_additionally'
  mount ActionCable.server => '/cable'
  resources :messages, only: [:create, :destroy]
  get 'rooms/show'
  devise_for :users
  root to: "users#index"
  resources :users, :only => [:index, :show]
  resources :dm_messages, :only => [:create, :destroy]
  resources :dm_rooms, :only => [:create, :show]
  resources :messages do
    # message_id取得を楽にするためにネスト
    resource :favorites, only: [:create, :destroy]
  end
end
