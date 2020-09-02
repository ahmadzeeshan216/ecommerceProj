Rails.application.routes.draw do

  root "home#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :products do
    delete :image_destroy, on: :member
    get :search, on: :collection
  end

  resources :cart_items do
    get :apply_coupon, on: :collection
  end

  resources :orders
  resources :comments
  resources :account, only: [:index]
  
end
