Rails.application.routes.draw do
  root 'books#index'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  get 'sessions/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'signup',   to: 'users#new',        as: 'signup'
  get 'login',    to: 'sessions#new',     as: 'login'
  get 'logout',   to: 'sessions#destroy', as: 'logout'

  resources :books
  resources :authors
  resources :shops, param: :slug
  resources :search, only: [:index]

end
