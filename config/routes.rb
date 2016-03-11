Rails.application.routes.draw do
  root "static_pages#home"
  get "about" => "static_pages#about"
  get "contact_us" => "static_pages#contact_us"
  get "help" => "static_pages#help"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :users, only: [:index, :show, :new, :create, :edit, :update]

  namespace :admin do
    root "users#show"
    resources :users
  end

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :relationships, only: [:create, :destroy]
end
