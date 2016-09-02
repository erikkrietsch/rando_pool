class WeeksController < ApplicationController
  expose(:season, find_by: :name, id: :season_name)
  expose(:week) { season.weeks.find_by number: params[:week_number] }
  expose(:games) { week.games.order :played_at }
  expose(:picks) { week.picks.sort_by(&:score).reverse }
  expose(:game_with_biggest_delta) { games.sort_by(&:delta).last }
  expose(:next_week) { week.next_week }
  expose(:prev_week) { week.prev_week }
  expose(:rando_pick) { week.random_pick }
end
