class Card
  attr_accessor :rank, :suit

  def initialize(rank:, suit:)
    @rank = rank
    @suit = suit
  end
  def ==(other)
    rank == other.rank && suit == other.suit
  end
  def hash
    [rank, suit].hash
  end
  def eql?(other)
    self == other
  end
  def output_card
    puts "The #{@rank} of #{@suit}"
  end
end
