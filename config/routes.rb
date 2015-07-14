Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  resources :organizations, only: [:new, :create, :show, :edit, :update] do
    resources :items, only: [:new, :create, :edit, :update, :destroy]
  end
end
