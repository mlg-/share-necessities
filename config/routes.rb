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

  resources :items, only: [:show] do
    resources :dibs, only: [:new, :create, :update, :destroy]
  end

  resources :thumbnails, only: [:new]

  resources :dibs, only: [:index]

  resources :imports, only: [:new, :create, :show]
end
