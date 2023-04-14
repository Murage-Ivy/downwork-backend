Rails.application.routes.draw do
  resources :posts
  resources :comments
  resources :users

  post "/signup", to: "users#create"
  post "/login", to: "auth_user#create"
end
