require 'rails_helper'

describe CurrentCharacter do
  describe ".all" do
    context "with two seasons" do
      it "only retuns the characters for the current season" do
        first_season = Season.create
        current_season = Season.create

        first_character = Character.create season: first_season
        current_character = Character.create season: current_season

        current_characters = CurrentCharacter.all
        expect(current_characters.count).to eq 1
        expect(current_characters.first.character).to eq current_character
      end
    end
  end

  describe "#id" do
    it "returns the id of the character" do
      character = Character.create
      current_character = CurrentCharacter.new(character)
      expect(current_character.id).to eq character.id
    end
  end

  describe "#player_name" do
    it "returns the name of the character's player" do
      player = Player.create name: "Player One"
      character = Character.create player: player
      current_character = CurrentCharacter.new(character)
      expect(current_character.player_name).to eq "Player One"
    end
  end
end
