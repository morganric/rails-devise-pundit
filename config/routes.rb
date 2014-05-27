Rails.application.routes.draw do
  resources :photos

  root :to => "visitors#index"
  devise_for :users
  resources :users
end
