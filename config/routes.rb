Rails.application.routes.draw do

  resources :situations, shallow: true do
      resources :events
  end

  resources :organizations

  root to: 'dashboards#index'
  devise_for :users, :controllers => { :registrations => "registrations" }

  resources :users

end
