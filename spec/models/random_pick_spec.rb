require 'rails_helper'

describe RandomPick do
  let(:home_team) { Team.create }
  let(:away_team) { Team.create }
  let(:week) { Week.create }

  before do
    week.games.create home_team: home_team, away_team: away_team,
      home_score: 7, away_score: 0
  end

  describe "#correct?" do
    context "with a winning pick" do
      it "returns true" do
        random_pick = RandomPick.create team: home_team, week: week
        expect(random_pick.correct?).to eq true
      end
    end

    context "with a losing pick" do
      it "returns false" do
        random_pick = RandomPick.create team: away_team, week: week
        expect(random_pick.correct?).to eq false
      end
    end
  end
end
