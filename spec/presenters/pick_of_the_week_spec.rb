require 'rails_helper'

describe PickOfTheWeekPresenter do
  describe "#text" do
    let(:week) { Week.create }
    let(:home_team) { Team.create name: "Bears" }
    let(:away_team) { Team.create name: "Packers" }
    let(:game1) { week.games.create home_team: home_team, away_team: away_team }

    context "with one game" do
      it "should return the message for that game" do
        game1.update_attributes home_score: 7, away_score: 0
        presenter = PickOfTheWeekPresenter.new week.games

        expect(presenter.text).to eq "The #{game1.winning_team.name} beat the #{game1.losing_team.name} by #{game1.delta}"
      end
    end

    context "with more than one game" do
      it "should return the message for those games" do
        game2 = week.games.create home_team: home_team, away_team: away_team
        game1.update_attributes home_score: 7, away_score: 0
        game2.update_attributes home_score: 7, away_score: 0
        presenter = PickOfTheWeekPresenter.new week.games

        expect(presenter.text).to eq "A tie! The #{game1.winning_team.name} and #{game2.winning_team.name} beat the #{game1.losing_team.name} and #{game2.losing_team.name} (respectively) by #{game1.delta}"
      end
    end
  end
end