#the Card class defines the property of a card. it has a rank, a suit and a value.
class Card
  attr_accessor :rank, :suit, :value
  def initialize(rank:, suit:)
    @rank = rank
    @suit = suit
    @value = case rank
    when 'J' then 10
    when 'Q' then 10
    when 'K' then 10
    when 'A' then 1
    else rank
    end
  end
  # the class functions below, together with the Set from the spec test, helps to define the equality between cards
  #cards are equal if they have the same rank and suit
  def ==(other)
    rank == other.rank && suit == other.suit
  end
  #hash code of the class depens on suit and rank. Same has code no repetition in a set
  def hash
    [rank, suit].hash
  end
  #this defines the equality between two Cards that have the same suit and rank
  def eql?(other)
    self == other
  end
  #this def is totally useless, I am keeping for now
  def output_card
    return "The #{@rank} of #{@suit}"
  end
end
