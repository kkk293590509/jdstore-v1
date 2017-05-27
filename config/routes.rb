Rails.application.routes.draw do

  namespace :account do
    resources :users
  end

  root 'products#index'
  devise_for :users
  namespace :admin do
    resources :products
  end
   resources :carts do
      collection do
        delete :clean
      end
    end
  resources :products do
    member do
      post :add_to_cart
    end
  end
end
