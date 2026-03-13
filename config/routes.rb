Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }

  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root
  end

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resource :dashboard, only: [:index]

  resources :users, only: [:show, :edit, :update]

  resources :expenses, only: [:index, :new, :create, :edit, :update, :destroy]

  resources :categories, only: [:index, :create, :destroy]

  resources :budgets, only: [:index, :create, :edit, :update]

  namespace :admin do
    resources :users, only: [:index, :destroy]
  end
end