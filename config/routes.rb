Rails.application.routes.draw do
  resources :comments

  resources :events

  resources :situations

  resources :organizations

  root to: 'dashboards#index'
  devise_for :users, :controllers => { :registrations => "registrations" }

  resources :users
end
