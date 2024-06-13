Rails.application.routes.draw do
  scope :music do
    resources :records, only: %i[index show] do
      collection do
        get "random"
      end
    end

    resources :categories, only: %i[index show] do
      resources :records, only: :index
    end

    resources :format_tags, only: %i[index show] do
      resources :records, only: :index
    end

    resources :songs, only: %i[index show] do
      resources :records, only: :index
      resources :related_songs, only: :index
    end

    resources :artists, only: %i[index show] do
      resources :related_songs, only: :index
      resources :records, only: :index
    end

    resources :song_groups, only: %i[index show] do
      resources :related_songs, only: :index
    end
  end

  namespace :admin do
    resources :artists do
      collection do
        get "fetch"
      end
    end

    resources :records
    resources :categories
    resources :format_tags
    resources :songs
    resources :song_groups
    resources :tracks
    resources :roles

    resources :attachments do
      member do
        delete "purge"
      end
    end
  end

  resources :admin
  resources :music, only: %i[index]

  get "player/fetch_audio" => "player#fetch_audio", as: :player_fetch_audio
  post "users/preferences/update" => "preferences#update", as: :users_preferences_update
  get "users/preferences" => "preferences#index", as: :users_preferences

  # delete "admin/attachments/:id/purge", to: "admin/attachments#purge", as: "admin_purge_attachment"

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "music#index"
end
