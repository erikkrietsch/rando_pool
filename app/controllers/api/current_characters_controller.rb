class Api::CurrentCharactersController < ApplicationController
  expose(:current_characters) { CurrentCharacter.all }
end
