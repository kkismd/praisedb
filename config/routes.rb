Rails.application.routes.draw do
  root to: "top#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :organizations
  resources :users

  resources :songs do
    member do
      get :detail
    end

    collection do
      get :search
      get :list
      get :list_all
      post :preview
    end
  end
end
