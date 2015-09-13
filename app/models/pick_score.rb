class PickScore
  def self.for(pick)
    new(pick).score
  end

  attr_reader :pick

  def initialize(pick)
    @pick = pick
  end

  def score
    return delta if scoring_week && character_won
    character_won ? 0 : -delta
  end

  private

  def scoring_week
    pick.week.scoring_week
  end

  def character_won
    pick.correct?
  end

  def delta
    pick.delta
  end
end
