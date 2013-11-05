class Card

  attr_reader :rank, :suit

  def initialize(args)
    @rank = args[:rank]
    @suit = args[:suit]
  end

  def ==(other)
    rank == other.rank
  end

  def <=>(other)
    index_of(rank) <=> index_of(other.rank)
  end

  def to_s
    "#{rank}#{suit}"
  end

  private

  def index_of(rank)
    Deck::RANKS.index(rank)
  end
end
