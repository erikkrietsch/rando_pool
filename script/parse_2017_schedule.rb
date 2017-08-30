require 'csv'
require 'open-uri'
require 'nokogiri'

class Team
  attr_accessor :location, :mascot

  def initialize(row)
    @location = row['location']
    @mascot = row['name']
  end

  def name
    [location, mascot].join ' '
  end
end

team_data = CSV.open './data/teams.csv', headers: true
teams = team_data.map { |row| Team.new row }
washington = teams.find { |team| team.location == 'Washington' }

html = open('https://www.sbnation.com/2017/4/20/15376922/2017-nfl-schedule-released-dates-times-highlights').read
html_doc = Nokogiri::HTML html
table = html_doc.css('table').first

games = []

class Game
  def initialize(week, played_at, away_mascot, home_mascot)
    @week = week
    @played_at = played_at
    @away_mascot = away_mascot
    @home_mascot = home_mascot
  end

  def cols
    [@week, @played_at, @away_mascot, @home_mascot]
  end
end

for row in table.css('tbody tr')
  (week_number, date, away_name, home_name, time, _) = row.css('td').map(&:content)
  played_at = DateTime.parse([date, time, -5].join(' '))

  away_team = teams.find { |team| team.name == away_name } || washington
  home_team = teams.find { |team| team.name == home_name } || washington

  games << Game.new(week_number, played_at, away_team.mascot, home_team.mascot)
end

csv_string = CSV.generate do |csv|
  csv << %w[week kickoff away_team home_team]
  games.each { |game| csv << game.cols }
end

puts csv_string
