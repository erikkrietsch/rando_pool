class Api::CurrentSeason::RandoPicksController < Api::CurrentSeasonController
  expose(:random_picks) { current_season.weeks.map(&:random_pick).compact }
  expose(:current_picks) { random_picks.map &CurrentPick.method(:new) }

  def create
    team = Team.find params[:team_id]
    week = current_season.weeks.find_by number: params[:week_number]
    random_pick = RandomPick.new team: team, week: week

    if random_pick.save
      render :index, status: :created
    end
  end
end
