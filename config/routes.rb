Rails.application.routes.draw do
  get "/home", to: "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  patch "/forgot-password", to: "sessions#forgot"

  resources :users
  resources :account_activations, only: %i(edit)
  resources :password_resets, except: %i(index show destroy)
  resources :microposts, only: %i(create destroy)
  root "static_pages#home"
end
