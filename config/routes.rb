Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }

  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "pages#top_page"
  end

  resource :dashboard, only: [:index]

  resources :users, only: [:show, :edit, :update]

  resources :expenses

  resources :categories
  resources :budgets

  namespace :admin do
    resources :users
  end
end