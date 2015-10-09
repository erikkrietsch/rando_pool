require 'request_spec_helper'

describe 'GET /api/current_season/rando_picks' do
  it "returns the rando picks for the current season" do
    season = Season.create
    week = Week.create season: season, number: 1
    team = Team.create
    RandomPick.create week: week, team: team

    get_json '/api/current_season/rando_picks'

    expect(response.code).to eq "200"
    expect(response_json).to eq(
      [
        { "week_number" => week.number, "team_id" => team.id }
      ]
    )
  end
end
