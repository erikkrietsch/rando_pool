require 'rails_helper'

describe Rando do
  let(:winning_team) { Team.create }
  let(:losing_team) { Team.create }
  let(:pick_team) { losing_team }

  before do
    attrs = {
      home_team: winning_team, home_score: 7,
      away_team: losing_team, away_score: 0
    }

    weeks = (1..3).map { Week.create.games.create(attrs).week }
    weeks.each { |week| RandomPick.create week: week, team: pick_team }
  end

  describe ".wins" do
    subject { Rando.wins }

    context "with none correct" do
      it { should eq 0 }
    end

    context "with one correct" do
      before { RandomPick.first.update_attribute :team, winning_team }
      it { should eq 1 }
    end

    context "with three correct" do
      let(:pick_team) { winning_team }
      it { should eq 3 }
    end
  end

  describe ".losses" do
    subject { Rando.losses }

    context "with none correct" do
      it { should eq 3 }
    end

    context "with one correct" do
      before { RandomPick.first.update_attribute :team, winning_team }
      it { should eq 2 }
    end

    context "with three correct" do
      let(:pick_team) { winning_team }
      it { should eq 0 }
    end
  end

  describe ".ratio" do
    subject { Rando.ratio }

    context "with none correct" do
      it { should eq "0.000" }
    end

    context "with one correct" do
      before { RandomPick.first.update_attribute :team, winning_team }
      it { should eq "0.333" }
    end

    context "with three correct" do
      let(:pick_team) { winning_team }
      it { should eq "1.000" }
    end
  end
end
