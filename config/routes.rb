Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :products
  resources :comments
  resources :cart_items
  resources :orders

  get "myaccount" => "account#index"
  get "search" => "home#search"
  get "apply_coupon" => "cart_items#apply_coupon"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
end
