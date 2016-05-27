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
    Character.pluck(:name).where("season_id = ? OR player_id = ?", @season.id, @player.id)
  end
end

# run like this:
# $ rake "add_player[Some Name]"
desc 'Add player to latest Season'
task :add_player, [:name] => :environment do |t, args|
  season = Season.order(:name).last
  player = Player.find_or_create_by name: args[:name]

  if Character.where(season: season, player: player).any?
    puts "player already added"
    exit 1
  end

  if name = ValidName.find(season, player)
    character = season.characters.create player: player, name: name
    puts name
  else
    puts "valid name not found"
    exit 2
  end
end
