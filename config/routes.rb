DallasrbWeb::Application.routes.draw do

  root :to => "home#index"
  match '/team' => "home#team"

  resources :members
  resources :users, :only => [:index, :show, :edit, :update ]

  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
end
