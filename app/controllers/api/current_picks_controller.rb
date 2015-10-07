class Api::CurrentPicksController < ApplicationController
  protect_from_forgery with: :null_session
  expose(:character) { Character.find params[:character_id] }
  expose(:current_picks) do
    picks = character.picks
    puts picks.count
    picks.map &CurrentPick.method(:new)
  end

  def create
    team = Team.find params[:team_id]
    week = character.season.weeks.find_by number: params[:week_number]
    pick = character.picks.build team: team, week: week

    if pick.save
      render :index, status: :created
    end
  end
end
