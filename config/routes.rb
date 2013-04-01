DallasrbWeb::Application.routes.draw do

  root :to => "home#index"
  match '/team' => "home#team"

  resources :members
  resources :events, :only => [:index, :show] do
    collection do
      get "current"
    end
  end

  namespace :admin do
    resources :users, :only => [:index, :show, :edit, :update]
    resources :events, :only => [:index, :new, :edit, :create, :update, :destroy] do
      member do
        get "copy"
      end
    end
  end

  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
end
