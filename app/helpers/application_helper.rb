module ApplicationHelper
  def rando_result(random_pick)
    game = random_pick.game

    if random_pick.correct?
      "No points this week - Rando's pick was the #{game.winning_team.name}, who beat the #{game.losing_team.name}."
    else
      "Points this week - Rando's pick was the #{game.losing_team.name}, who lost to the #{game.winning_team.name}."
    end
  end

  def pick_result(pick)
    return "-" unless pick.game_complete?
    pick.correct? ? "Won" : "Lost"
  end

  def character_status(character)
    character.out ? "Out" : "In"
  end
end
