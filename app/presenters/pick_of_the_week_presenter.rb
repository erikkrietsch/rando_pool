class PickOfTheWeekPresenter
  def initialize(games)
    @games = games.sort_by(&:delta)
  end

  def text
    return "#{"A tie! " if multiple_picks?}The #{winners} beat the #{losers} #{"(respectively) " if multiple_picks?}by #{delta}"
  end

  private

  def winners
    joined_names :winning_team
  end

  def losers
    joined_names :losing_team
  end

  def delta
    games.last.delta
  end

  def multiple_picks?
    picks.count > 1
  end

  def picks
    games.select{ |game| game.delta == delta }
  end

  def games
    @games
  end

  def joined_names(team)
    picks.map{ |pick| pick.send(team).name }.join(" and ")
  end
end