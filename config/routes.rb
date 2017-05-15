Rails.application.routes.draw do
  namespace :account do
    resources :users
  end
  devise_for :users
  root 'welcome#index'
end
