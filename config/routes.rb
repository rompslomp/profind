Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root "home#index"
  get "home/index", to: "home#index"

  resources :services, only: %i[index show new create edit update destroy] do
    resources :quotes, only: %i[new create]
    member do
      post :add_tag
      delete :remove_tag
    end
  end

  resources :quotes, only: %i[index show destroy]
  resources :tags, only: %i[index show]

  namespace :admin do
    root "dashboard#index"
    resources :tags
    resources :users, only: %i[index show] do
      member do
        patch :update_role
      end
    end
    resources :provider_requests, only: %i[index] do
      member do
        patch :approve
        patch :reject
      end
    end
  end

  resources :provider_requests, only: %i[new create]

  get "up" => "rails/health#show", as: :rails_health_check
end
