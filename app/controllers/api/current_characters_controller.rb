class Api::CurrentCharactersController < ApiController
  expose(:current_characters) { CurrentCharacter.all }
end
