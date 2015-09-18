require 'request_spec_helper'

describe "GET /api/teams" do
  it "returns the teams" do
    bears = Team.create name: "Bears"
    seahawks = Team.create name: "Seahawks"

    get_json '/api/teams'

    expect(response.code).to eq "200"
    expect(response_json).to eq(
      [
        {
          "id" => bears.id,
          "name" => "Bears",
        },
        {
          "id" => seahawks.id,
          "name" => "Seahawks",
        }
      ]
    )
  end
end
