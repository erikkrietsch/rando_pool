class Api::CurrentSeason::CharactersController < Api::CurrentSeasonController
  expose(:current_characters) { CurrentCharacter.all(current_season) }
end
