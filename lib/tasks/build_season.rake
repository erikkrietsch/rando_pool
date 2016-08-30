require 'csv'

class SeasonBuilder
  def self.build(season_name, data)
    new(season_name, data).build
  end

  def initialize(season_name, data)
    @season_name = season_name
    @data = data
  end

  def build
    create_season
    create_weeks
    create_games
  end

  private

  def create_season
    @season = Season.create name: @season_name
  end

  def create_weeks
    (1..17).each { |i| @season.weeks.create number: i }
  end

  def create_games
    game_attrs.each &Game.method(:create)
  end

  def game_attrs
    @data.map do |row|
      {
        week:       @season.weeks.find_by(number: row["week"].to_i),
        played_at:  DateTime.parse(row["kickoff"]),
        away_team:  Team.find_by(name: row["away_team"]),
        home_team:  Team.find_by(name: row["home_team"])
      }
    end
  end
end

# run like this:
# $ rake "build_season[2016]"
desc 'Build season from schedule data.'
task :build_season, [:season_name] => :environment do |t, args|
  season_name = args[:season_name]

  if Season.where(name: season_name).any?
    puts "Season already built!"
    exit 1
  end

  filename = "data/#{season_name}-schedule.csv"

  unless File.file? filename
    puts "Missing data file - looked here: #{builder.filename}"
    exit 2
  end

  data = CSV.read filename, headers: true
  SeasonBuilder.build season_name, data
end
