require 'csv'

class ValidName
  def self.find(season, player)
    new(season, player).find
  end

  def initialize(season, player)
    @season, @player = season, player
  end

  def find
    available_names.sample
  end

  private

  def available_names
    names - used_names
  end

  def names
    CSV.read('data/characters.csv').flatten
  end

  def used_names
    Character.where("season_id = ? OR player_id = ?", @season.id, @player.id).pluck(:name)
  end
end

# run like this:
# $ rake "pick_character[2016,Nate]"
desc 'Pick a character for the given Season for a given Player.'
task :pick_character, [:season_name, :player_name] => :environment do |t, args|
  season = Season.find_by name: args[:season_name]
  player = Player.find_or_create_by name: args[:player_name]

  if Character.where(season: season, player: player).any?
    puts "player already added"
    exit 1
  end

  if name = ValidName.find(season, player)
    character = season.characters.create player: player, name: name
    puts characters.name
  else
    puts "valid name not found"
    exit 2
  end
end
