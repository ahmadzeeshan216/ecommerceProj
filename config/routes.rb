Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :products
  resources :comments
 
  get "myaccount" => "account#index"
  get "search" => "home#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
end
