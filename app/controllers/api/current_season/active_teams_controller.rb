class Api::CurrentSeason::ActiveTeamsController < ApplicationController
  expose(:week) { Week.find_by number: params[:week_number] }
  expose(:active_teams) { week.active_teams }
end
