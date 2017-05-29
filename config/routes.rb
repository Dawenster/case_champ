Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root "pages#landing"

  resources :competitions do
    collection do
      get :confirmation
    end
  end

  resources :users, only: [] do
    collection do
      post :login
    end
  end

  resources :interests, only: [:create, :destroy]
end
