require 'request_spec_helper'

describe 'GET /api/current_characters' do
  it "returns the current characters" do
    season = Season.create
    player = Player.create name: "Player One"
    character = Character.create season: season, player: player

    get_json '/api/current_characters'

    expect(response.code).to eq "200"
    expect(response_json).to eq(
      [
        {
          "id" => character.id,
          "player_name" => player.name
        }
      ]
    )
  end
end
