Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "health", to: 'application#health'
  namespace :studio_booking do
    resources :studio,only:[], param: :slug do
      resources :lessons, only:[:index,:show,:create,:update] do
        member do
          post 'cancel'
          post 'reinstate'
          get 'bookings'
          post 'bookings'
        end
      end
      resources :cancellation_policy, only:[:index]
      resources :students, only: [:show,:index] do
        member do
          get 'lessons'
        end
      end
    end
  end
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
