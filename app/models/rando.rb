class Rando
  def self.wins
    RandomPick.all.select(&:correct?).count
  end

  def self.losses
    RandomPick.count - self.wins
  end

  def self.ratio
    ratio = self.wins / RandomPick.count.to_f
    sprintf( "%0.03f", ratio)
  end
end
