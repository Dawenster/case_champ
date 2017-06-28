Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root "pages#landing"

  resources :competitions, except: [:edit, :destroy] do
    collection do
      get :confirmation
    end
  end

  resources :users, only: [:show] do
    collection do
      post :login
      delete :logout
    end
  end

  resources :interests, only: [:create, :destroy]

  resources :event_files, only: [:create, :destroy]

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
end
