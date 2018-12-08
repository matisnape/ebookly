Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'books#index'

  resources :books
  resources :authors
  resources :shops, param: :slug

  #API
  namespace :api do
    namespace :v1 do
      resources :books
      resources :authors
      resources :shops
    end
  end
end
