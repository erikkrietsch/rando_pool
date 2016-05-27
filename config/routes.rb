Rails.application.routes.draw do
  get '/seasons', to: 'seasons#index', as: :seasons
  get '/seasons/:season_name', to: 'seasons#show', as: :season
  get '/seasons/:season_name/weeks/:week_number', to: 'weeks#show', as: :season_week
  get '/seasons/:season_name/characters/:character_id', to: 'characters#show', as: :season_character

  namespace :api do
    get :teams, to: 'teams#index'

    namespace :current_season do
      get :characters, to: 'characters#index'
      get :rando_picks, to: 'rando_picks#index'
      post :rando_picks, to: 'rando_picks#create'
      get 'weeks/:week_number/active_teams', to: 'active_teams#index'
      post :picks, to: 'picks#create'
    end
  end

  root to: 'pages#home'
end
