Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users, skip: :all

  # Built-in Health Check Endpoint
  get "health" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :create, :update] do
        collection do
          post :sign_in, controller: :sessions, action: :create
          post :two_factor_sign_in, controller: :sessions, action: :two_factor_sign_in
          post :verify_two_factor_auth_token, controller: :sessions, action: :verify_two_factor_auth_token
          post :google_auth, controller: :sessions, action: :google_auth
          put :recovery_password
          put :update_password
        end
      end
    end
  end
end
