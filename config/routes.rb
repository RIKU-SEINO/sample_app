Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, onlt: [:new, :create, :edit, :update]
  get '/signup', to: 'users#new'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  root "static_pages#home"
end
