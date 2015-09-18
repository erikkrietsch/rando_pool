Rails.application.routes.draw do
  get '/seasons', to: 'seasons#index', as: :seasons
  get '/seasons/:season_name', to: 'seasons#show', as: :season
  get '/seasons/:season_name/weeks/:week_number', to: 'weeks#show', as: :season_week

  get '/api/teams', to: 'api/teams#index'

  root to: 'pages#home'
end
