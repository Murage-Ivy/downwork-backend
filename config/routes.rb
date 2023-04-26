Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end
  resources :users

  post "/signup", to: "users#create"
  post "/login", to: "auth_user#create"
  get "/auto_login", to: "users#profile"
end
