Rails.application.routes.draw do
  scope :music do
    resources :records, only: %i[index show]
    resources :categories, only: %i[index show]
    resources :format_tags, only: %i[index show]
    resources :songs, only: %i[index show]
    resources :artists, only: %i[index show]
    resources :song_titles, only: %i[index show]
  end

  namespace :admin do
    resources :records
    resources :categories
    resources :format_tags
    resources :songs
    resources :artists
    resources :song_titles
  end

  resources :admin
  resources :music

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "records#index"
end
