class Api::CurrentSeason::ActiveTeamsController < ApplicationController
  expose(:current_season) { Season.order(:id).last }
  expose(:week) { current_season.weeks.find_by number: params[:week_number] }
  expose(:active_teams) { week.active_teams }
end
