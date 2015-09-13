desc 'Lead Random Picks'
task load_random_picks: :environment do
  [
    { week: 1,  name: "Texans" },
    { week: 2,  name: "Packers" },
    { week: 3,  name: "Redskins" },
    { week: 4,  name: "Steelers" },
    { week: 5,  name: "Buccaneers" },
    { week: 6,  name: "Raiders" },
    { week: 7,  name: "Raiders" },
    { week: 8,  name: "Chargers" },
    { week: 9,  name: "Bengals" },
    { week: 10, name: "Bears" },
    { week: 11, name: "Seahawks" },
    { week: 12, name: "Raiders" },
    { week: 13, name: "Eagles" },
    { week: 14, name: "Ravens" },
    { week: 15, name: "Patriots" },
    { week: 16, name: "Texans" },
    { week: 17, name: "Patriots" }
  ].each do |pick|
    week = Week.find pick[:week]
    team = Team.find_by name: pick[:name]
    RandomPick.create week: week, team: team
  end
end
