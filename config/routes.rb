Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #
  # --- public routes ---
  resources :users, only: %i[ new create ]
  resources :sessions, only: %i[ new create ]
  get "sign_in", controller: "sessions", action: :new, as: :sign_in
  get "sign_up", controller: "users", action: :new, as: :sign_up

  # --- authenticated routes ---
  constraints(AuthenticatedConstraint.new) do
    resources :lists
    resources :tasks do
      collection do
        get "inbox", defaults: { filter: "inbox" }
        get "today", defaults: { filter: "today" }
      end
    end

    root "tasks#index", as: :user_root
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "sessions#new"
end
