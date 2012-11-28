Kozak::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :users
  resources :sessions
  resources :entries
  resources :asseters, :only => [:show, :create, :destroy]
  root :to => "entries#index"
end
