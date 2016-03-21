Rails.application.routes.draw do
  root "static_pages#home"
  get "about" => "static_pages#about"
  get "contact_us" => "static_pages#contact_us"
  get "help" => "static_pages#help"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :users, except: [:destroy, :new, :create]

  namespace :admin do
    root "users#show"
    resources :users
    resources :categories
    resources :words
  end

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :relationships, only: [:index, :create, :destroy]
  resources :categories, only: [:index]
  resources :lessons, except: [:destroy]
  resources :results, only: [:index]
  resources :words, only: [:index]
end
