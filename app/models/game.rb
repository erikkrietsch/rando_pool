class Game < ActiveRecord::Base
  belongs_to :home_team, class_name: Team
  belongs_to :away_team, class_name: Team
  belongs_to :week

  def winning_team
    home_score > away_score ? home_team : away_team
  end

  def losing_team
    home_score < away_score ? home_team : away_team
  end

  def delta
    (home_score - away_score).abs
  end
end
