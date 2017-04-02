Rails.application.routes.draw do
  get 'posts/index'

  devise_for :users, controllers: { sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#index'

  resources :users, only: [:index,:show] do
  	resources :friend_requests, only: [:index, :create, :destroy, :show]
  end
  
  resources :posts, only: [:index, :create]
  resources :friendships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create]
end
