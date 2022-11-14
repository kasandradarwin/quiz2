Rails.application.routes.draw do

  resources :ideas
  resource :user
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :destroy, :create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'ideas#index'


  # resources :ideas do

  #   resources :reviews, only: [:create, :destroy]

  # end
end
