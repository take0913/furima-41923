Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  
  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
  resources :orders, only: [:index, :create]
  end
end
