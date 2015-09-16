class SeasonsController < ApplicationController
  expose(:seasons)
  expose(:season) { Season.find_by name: params[:season_name] }
  expose(:weeks) { season.weeks }
  expose(:characters) { season.characters.sort_by(&:score).reverse }
end
