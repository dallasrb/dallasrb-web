DallasrbWeb::Application.routes.draw do

  root :to => "home#index"
  match '/team' => "home#team"

  match 'profiles/search' => 'profiles#search'
  resources :profiles do
    get 'page/:page', :action => :index, :on => :collection
    get :autocomplete_profile_name, :on => :collection
  end

  resources :events, :only => [:index, :show] do
    collection do
      get "current"
    end
  end

  namespace :admin do
    resources :users, :only => [:index, :show, :edit, :update, :destroy]
    resources :events, :only => [:index, :new, :edit, :create, :update, :destroy] do
      member do
        get "copy"
      end
    end
    resources :profiles, :only => [:index, :update]
  end

  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
end
