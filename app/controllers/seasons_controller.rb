class SeasonsController < ApplicationController
  expose(:seasons) { Season.all }
  expose(:season, find_by: :name, id: :season_name)
  expose(:weeks) { season.weeks }
  expose(:characters) { season.characters.sort_by(&:score).reverse }
end
