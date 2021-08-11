Rails.application.routes.draw do
  root to: 'top#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :homes
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

  resources :bookmarks do
    collection do
      post :create_remote, :as => :add
    end
  end

  resources :folders do
    member do
      get :content, :as => :content_of
      post :reorder, :as => :reorder
    end
    collection do
      post :set_current, :as => :set_current
      post :create_remote, :as => :add
    end
  end

  resources :books do
    collection do
      get :search
    end
  end

  resources :slides do
    member do
      get :detail
    end

    collection do
      get :search
      get :list
      post :preview
    end
  end
end
