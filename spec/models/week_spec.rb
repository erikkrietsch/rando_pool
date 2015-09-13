require 'rails_helper'

describe Week do
  let(:home_team) { Team.create }
  let(:away_team) { Team.create }
  let(:week) { Week.create }

  before do
    week.games.create home_team: home_team, away_team: away_team
  end

  describe "#game_for" do
    context "with a home team" do
      it "returns the game for that team" do
        game = week.game_for(home_team)
        expect(game.home_team).to eq home_team
      end
    end

    context "with an away team" do
      it "returns the game for that team" do
        game = week.game_for(away_team)
        expect(game.away_team).to eq away_team
      end
    end
  end
end
