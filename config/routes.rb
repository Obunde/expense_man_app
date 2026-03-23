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

  # get "/dashboard", to: "dashboard#index", as: :dashboard
  resources :dashboards, only: [:index]

  resources :users, only: [:show, :edit, :update]

  resources :expenses, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  resources :categories, only: [:index, :create, :update, :edit, :destroy]
  resources :budgets, except: [:show, :destroy]

  namespace :admin do
    resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  resource :guest_session, only: [:create, :destroy]
end