Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root "pages#landing"

  resources :competitions do
    collection do
      get :confirmation
    end
  end
end
