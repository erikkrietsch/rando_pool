class CharactersController < ApplicationController
  expose(:season, finder: :find_by_name, finder_parameter: :season_name)
  expose(:character)
end
