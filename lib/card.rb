class Card
  attr_accessor :rank, :suit
  attr_reader :value

  def initialize(rank:, suit:)
    @rank = rank
    @suit = suit
    @value = case rank
    when 'J' then 10
    when 'Q' then 10
    when 'K' then 10
    else rank
    end
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
