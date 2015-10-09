class Api::CurrentSeason::CharactersController < ApiController
  expose(:current_characters) { CurrentCharacter.all }
end
