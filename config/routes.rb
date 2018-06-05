Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products, only: [:index, :show] do
    member do
      post :add_product_to_cart
      post :remove_from_cart  
      post :add_cart_item_quantity
      post :minus_cart_item_quantity
      get :view_cart
    end
  end
  resources :orders

  root "products#index"

  namespace :admin do
    resources :products, except: :show
    resources :orders, only: [:index, :edit, :update]
    root "products#index"
  end


end
