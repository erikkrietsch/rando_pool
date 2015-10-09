require 'csv'
require 'open-uri'

class DataLoader
  def initialize(path)
    @path = path
  end

  def import_teams
    attrs = team_data.map do |row|
      { location: row["location"], name: row["name"] }
    end

    attrs.each &Team.method(:create)
  end

  def import_season
    attrs = season_data.map do |row|
      {
        week:       Week.find_by(number: row["week"].to_i),
        home_team:  Team.find_by(name: row["home_team"]),
        away_team:  Team.find_by(name: row["visiting_team"]),
        home_score: row["home_score"].to_i,
        away_score: row["visitors_score"].to_i,
        played_at:  DateTime.parse(row["kickoff"])
      }
    end

    attrs.each &Game.method(:create)
  end

  def import_rando
    attrs = rando_data.map do |row|
      {
        week: Week.find_by(number: row["week"].to_i),
        team: Team.find_by(name: row["team"])
      }
    end

    attrs.each &RandomPick.method(:create)
  end

  def import_players
    season = Season.first

    player_data.each do |row|
      player = Player.create name: row["player"]
      player.characters.create name: row["character"], season: season
    end
  end

  def import_picks
    attrs = pick_data.map do |row|
      {
        week: Week.find_by(number: row["week"].to_i),
        team: Team.find_by(name: row["team"]),
        character: Character.find_by(name: row["character"])
      }
    end

    attrs.each &Pick.method(:create)
  end

  def import_schedule(season)
    data = data_for "/#{season.name}-schedule.csv"

    attrs = data.map do |row|
      {
        week:       season.weeks.find_by(number: row["week"].to_i),
        home_team:  Team.find_by(name: row["home_team"]),
        away_team:  Team.find_by(name: row["away_team"]),
        played_at:  DateTime.parse(row["kickoff"])
      }
    end

    attrs.each &Game.method(:create)
  end

  private

  def team_data
    data_for '/teams.csv'
  end

  def season_data
    data_for '/2014-games.csv'
  end

  def rando_data
    data_for '/2014-rando-picks.csv'
  end

  def player_data
    data_for '/2014-players.csv'
  end

  def pick_data
    data_for '/2014-picks.csv'
  end

  def data_for(file)
    uri = @path + file
    CSV.new open(uri), { headers: true }
  end
end

desc 'Load initial data by providing uri'
task :load_data, [:uri] => :environment do |t, args|
  season = Season.create name: '2014'

  (1..17).each do |i|
    season.weeks.create number: i
  end

  loader = DataLoader.new args[:uri]
  loader.import_teams
  loader.import_season
  loader.import_rando
  loader.import_players
  loader.import_picks
end

# run like this:
# $ rake "load_schedule[2015,data]"
task :load_schedule, [:year, :uri] => :environment do |t, args|
  season = Season.create name: args[:year]

  (1..17).each do |i|
    season.weeks.create number: i
  end

  loader = DataLoader.new args[:uri]
  loader.import_schedule(season)
end
