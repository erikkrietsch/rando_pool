class Api::CurrentSeason::ActiveTeamsController < Api::CurrentSeasonController
  expose(:week) { current_season.weeks.find_by number: params[:week_number] }
  expose(:active_teams) { week.active_teams }
end
