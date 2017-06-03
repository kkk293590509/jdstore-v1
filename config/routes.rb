Rails.application.routes.draw do

  namespace :account do
    resources :users
    resources :orders
  end

  root 'welcome#index'
  #root 'products#index'

  devise_for :users
  namespace :admin do
        resources :products
        resources :orders do
            member do
             post :cancel
             post :ship
             post :shipped
             post :return
         end
      end
  end

  resources :carts do
    collection do
      delete :clean
      post :checkout
    end
  end

  resources :products do
    member do
      post :add_to_cart
    end
  end

  resources :orders do
    member do
            post :pay_with_alipay
            post :pay_with_wechat
            post :apply_to_cancel
     end
   end

  resources :cart_items do
     member do
       patch :update_choose_staus
     end
   end

end
