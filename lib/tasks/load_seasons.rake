require 'csv'

desc 'Load the Seasons data'
task load_seasons: :environment do
  data = CSV.read('data/2014.csv', { headers: true })

  season = Season.create name: '2014'

  17.times do
    season.weeks.create
  end

  for row in data
    week = Week.find row["week"].to_i

    home_team = Team.find_by name: row["home_team"]
    away_team = Team.find_by name: row["visiting_team"]

    played_at = DateTime.parse row["kickoff"]

    game_attrs = {
      home_team: home_team,
      away_team: away_team,
      home_score: row["home_score"].to_i,
      away_score: row["visitors_score"].to_i,
      played_at: played_at
    }

    week.games.create game_attrs
  end
end
