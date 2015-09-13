require 'csv'

desc 'Load the Pick data'
task load_picks: :environment do
  season = Season.first

  [
    { player: "Nate",    character: "Grand Moff Tarkin" },
    { player: "Laura",   character: "Obi-Wan Kenobi" },
    { player: "Cameron", character: "Captain Rex" },
    { player: "Meg",     character: "Boba Fett" },
    { player: "Liz",     character: "Mace Windu" },
    { player: "Don",     character: "Greedo" },
    { player: "Tim",     character: "Darth Vader" },
    { player: "Andrew",  character: "Darth Maul" },
    { player: "Jess",    character: "Padme Amidala" },
    { player: "Ryan",    character: "Kit Fisto" }
  ].each do |pair|
    player = Player.create name: pair[:player]
    player.characters.create name: pair[:character], season: season
  end

  data = CSV.read('data/2014-picks.csv', { headers: true })

  for row in data
    team = Team.find_by name: row["team"]
    character = Character.find_by name: row["character"]

    character.picks.create week_id: row["week"].to_i, team: team
  end
end
