Rails.application.routes.draw do
  resources :posts
  resources :comments
  resources :users

  post "/signup", to: "users#create"
  post "/login", to: "auth_user#create"
  get "/auto_login", to: "users#profile"
  delete "logout", to: "users#destroy"
end
