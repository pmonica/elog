Rails.application.routes.draw do

  get 'tags/index'

  get 'tags/new'

  get 'situations/print/:id', to: 'situations#print', as: 'situation_print'

  get 'situations/pdf/:id', to: 'situations#pdf', as: 'situation_pdf'

  get 'tags/edit/:id', to: 'tags#edit', as: 'tags_edit'

  post 'tags/create', to: 'tags#create', as: 'tags_create'

  post 'tags/update/:id', to: 'tags#update', as: 'tags_update'

  get 'tags/destroy/:id', to: 'tags#destroy', as: 'tags_destroy'

  resources :situations, shallow: true do
      resources :events, shallow: true  do
      	resources :comments
      end
  end

  resources :organizations

  root to: 'dashboards#index'
  devise_for :users, :controllers => { :registrations => "registrations" }

  resources :users

end
