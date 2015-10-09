require 'request_spec_helper'

describe 'GET /api/current_season/weeks/:week_number/active_teams' do
  it "returns the active teams for that week" do
    home_team = Team.create
    away_team = Team.create

    week = Week.create number: 1
    week.games.create home_team: home_team, away_team: away_team

    get_json "/api/current_season/weeks/#{week.number}/active_teams"

    expect(response.code).to eq "200"
    expect(response_json).to eq [home_team.id, away_team.id]
  end
end
