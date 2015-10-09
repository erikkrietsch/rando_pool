Rails.application.routes.draw do
  get '/seasons', to: 'seasons#index', as: :seasons
  get '/seasons/:season_name', to: 'seasons#show', as: :season
  get '/seasons/:season_name/weeks/:week_number', to: 'weeks#show', as: :season_week

  namespace :api do
    get :teams, to: 'teams#index'

    namespace :current_season do
      get :characters, to: 'characters#index'
      post :picks, to: 'picks#create'
    end
  end

  root to: 'pages#home'
end
