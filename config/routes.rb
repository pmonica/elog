Rails.application.routes.draw do
  resources :situations

  resources :organizations

  root to: 'dashboards#index'
  devise_for :users
  resources :users
end
