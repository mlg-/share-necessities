Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users, controllers: { invitations: "users/invitations" }

  resources :organizations, except: [:destroy] do
    resources :items, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :items do
    resources :dibs, only: [:new, :create, :update, :destroy]
  end

  resources :dibs, only: [:index]
end
