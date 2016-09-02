class CharactersController < ApplicationController
  expose(:season, find_by: :name, id: :season_name)
  expose(:character)
end
