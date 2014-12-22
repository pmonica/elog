Rails.application.routes.draw do
  resources :situations

  resources :organizations

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
