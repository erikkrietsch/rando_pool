class Week < ActiveRecord::Base
  belongs_to :season
  has_many :games
  has_many :picks
  has_one :random_pick

  def scoring_week
    !random_pick.correct?
  end

  def game_for(team)
    games.where("home_team_id = ? OR away_team_id = ?", team.id, team.id).first
  end

  def next_week
    season.weeks.where(number: number + 1).first
  end

  def prev_week
    season.weeks.where(number: number - 1).first
  end
end
