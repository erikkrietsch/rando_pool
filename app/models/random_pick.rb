class RandomPick < ActiveRecord::Base
  belongs_to :week
  belongs_to :team

  def correct?
    game.winning_team == team
  end

  private

  def game
    @game ||= week.game_for team
  end
end
