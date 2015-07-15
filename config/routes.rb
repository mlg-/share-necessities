Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users, controllers: { invitations: "users/invitations" }

  resources :organizations, only: [:new, :create, :show, :edit, :update] do
    resources :items, only: [:new, :create, :edit, :update, :destroy]
  end
end
