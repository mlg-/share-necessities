Rails.application.routes.draw do
  root "homes#index"
  devise_for :users, controllers: { invitations: "users/invitations" }

  resources :organizations, except: [:destroy] do
    resources :items, except: [:show]
  end

  resources :items do
    collection do
      get "search"
    end
  end

  resources :items do
    resources :dibs, only: [:new, :create, :update, :destroy]
  end

  resources :dibs, only: [:index]
end
