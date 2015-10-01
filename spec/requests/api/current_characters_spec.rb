require 'request_spec_helper'

describe 'GET /api/current_characters' do
  it "returns the current characters" do
    team = Team.create
    season = Season.create
    week = season.weeks.create number: 1
    player = Player.create name: "Player One"
    character = Character.create season: season, player: player
    character.picks.create week: week, team: team

    get_json '/api/current_characters'

    expect(response.code).to eq "200"
    expect(response_json).to eq(
      [
        {
          "id" => character.id,
          "player_name" => player.name,
          "picks" => [
            { "week_number" => week.number, "team_id" => team.id }
          ]
        }
      ]
    )
  end
end
