Rails.application.routes.draw do
  resources :posts
  resources :comments
  resources :users

  post "/signup", to: "users#create"
  # post "/login", to: "users#login"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
