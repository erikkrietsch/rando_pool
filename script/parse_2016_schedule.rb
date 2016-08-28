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

html = open('http://www.sbnation.com/nfl/2016/4/14/11435628/2016-nfl-schedule-released-dates-times-regular-season').read
html_doc = Nokogiri::HTML html
table = html_doc.css('table').first

tds = {}
harvest = false

for td in table.css('td')
  if /WEEK/.match td.text
    week_number = td.text.split(' ').last
    tds[week_number] = []
    harvest = true
  elsif harvest
    tds[tds.keys.last] << td
  end
end

games = []

class Game
  attr_accessor :week, :played_at, :away_mascot, :home_mascot

  def initialize(week, away_mascot, home_mascot)
    @week = week
    @away_mascot = away_mascot
    @home_mascot = home_mascot
  end

  def cols
    [week, played_at, away_mascot, home_mascot]
  end
end

date = nil

for (week_number, tds) in tds
  for td in tds
    next if /Bye/.match td.text

    if /:/.match td.text
      games.last.played_at = DateTime.parse("#{date} #{td.text}m -5")
    elsif / at /.match td.text
      away_name, home_name = td.text.split(' at ').map { |name| name.gsub(/[^\w\s].*/, '').strip }

      away_team = teams.find { |team| team.name == away_name } || washington
      home_team = teams.find { |team| team.name == home_name } || washington

      games << Game.new(week_number, away_team.mascot, home_team.mascot)
    else
      begin
        DateTime.parse(td.text)
        date = td.text
      rescue
        # noop
      end
    end
  end
end

csv_string = CSV.generate do |csv|
  csv << %w[week kickoff away_team home_team]
  games.each { |game| csv << game.cols }
end

puts csv_string
