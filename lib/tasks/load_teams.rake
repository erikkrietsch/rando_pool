desc 'Load the Teams table'
task load_teams: :environment do
  [
    { location: "Chicago",       name: "Bears" },
    { location: "Arizona",       name: "Cardinals" },
    { location: "Green Bay",     name: "Packers" },
    { location: "New York",      name: "Giants" },
    { location: "Detroit",       name: "Lions" },
    { location: "Washington",    name: "Redskins" },
    { location: "Pittsburgh",    name: "Steelers" },
    { location: "Philadelphia",  name: "Eagles" },
    { location: "St. Louis",     name: "Rams" },
    { location: "San Francisco", name: "49ers" },
    { location: "Cleveland",     name: "Browns" },
    { location: "Indianapolis",  name: "Colts" },
    { location: "Dallas",        name: "Cowboys" },
    { location: "Oakland",       name: "Raiders" },
    { location: "New England",   name: "Patriots" },
    { location: "Tennessee",     name: "Titans" },
    { location: "Denver",        name: "Broncos" },
    { location: "San Diego",     name: "Chargers" },
    { location: "New York",      name: "Jets" },
    { location: "Kansas City",   name: "Chiefs" },
    { location: "Buffalo",       name: "Bills" },
    { location: "Minnesota",     name: "Vikings" },
    { location: "Miami",         name: "Dolphins" },
    { location: "Atlanta",       name: "Falcons" },
    { location: "New Orleans",   name: "Saints" },
    { location: "Cincinnati",    name: "Bengals" },
    { location: "Seattle",       name: "Seahawks" },
    { location: "Tampa Bay",     name: "Buccaneers" },
    { location: "Jacksonville",  name: "Jaguars" },
    { location: "Carolina",      name: "Panthers" },
    { location: "Baltimore",     name: "Ravens" },
    { location: "Houston",       name: "Texans" }
  ].each do |team|
    Team.create(team)
  end
end
