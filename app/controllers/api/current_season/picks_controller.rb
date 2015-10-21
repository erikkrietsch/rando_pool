class Api::CurrentSeason::PicksController < Api::CurrentSeasonController
  expose(:character) { Character.find params[:character_id] }
  expose(:current_picks) { character.picks.map &CurrentPick.method(:new) }

  def create
    team = Team.find params[:team_id]
    week = character.season.weeks.find_by number: params[:week_number]
    pick = character.picks.build team: team, week: week

    if pick.save
      render :index, status: :created
    end
  end
end
