class CurrentCharacter
  def self.all
    current_season = Season.order(:id).last
    current_season.characters.map &self.method(:new)
  end

  attr_reader :character

  delegate :id, :player, to: :character

  def initialize(character)
    @character = character
  end

  def player_name
    player.name
  end

  def current_picks
    character.picks.map &CurrentPick.method(:new)
  end
end
