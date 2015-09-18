module ApplicationHelper
  def rando_result(week)
    random_pick = week.random_pick
    game = random_pick.game

    if random_pick.correct?
      "No points this week - Rando's pick was the #{game.winning_team.name}, who beat the #{game.losing_team.name}."
    else
      "Points this week - Rando's pick was the #{game.losing_team.name}, who lost to the #{game.winning_team.name}."
    end
  end
end
