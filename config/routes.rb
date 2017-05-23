Rails.application.routes.draw do
  namespace :admin do
    resources :products
  end

  namespace :account do
    resources :users
  end
  devise_for :users
  root 'welcome#index'
end
