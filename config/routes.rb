Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products, only: [:index, :show] do
    member do
      post :add_product_to_cart
    end
  end

  root "products#index"

  namespace :admin do
    resources :products, except: :show
    root "products#index"
  end


end
