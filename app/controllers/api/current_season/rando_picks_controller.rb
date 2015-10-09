class Api::CurrentSeason::RandoPicksController < ApplicationController
  expose(:season) { Season.order(:id).last }
  expose(:random_picks) { season.weeks.map &:random_pick }
  expose(:current_picks) { random_picks.map &CurrentPick.method(:new) }
end
