Rails.application.routes.draw do

  # resources :ideas
  # resources :reviews

  # resource :user
  resources :user_signed_in
  resources :users
  resource :session, only: [:new, :destroy, :create]

  # resources :likes, shallow: true,  only: [:create, :destroy]
  # get :liked, on: :collection



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'ideas#index'

  resources :ideas do
    resources :reviews, only: [:new, :create, :destroy]
    resources :likes, shallow: true, only: [:create, :destroy]
  end
end
