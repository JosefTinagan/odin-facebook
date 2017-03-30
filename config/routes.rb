Rails.application.routes.draw do
  get 'posts/index'

  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#index'

  resources :users, only: [:index] do
  	resources :friend_requests, only: [:index, :create, :destroy, :show]
  	resources :posts, only: [:index, :create]
  end
  
  resources :friendships, only: [:create, :destroy]

end
