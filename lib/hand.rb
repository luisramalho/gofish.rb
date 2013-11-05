class Hand
  extend Forwardable

  def_delegators :@cards, :count, :<<, :delete, :sort!, :empty?

  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def random_rank
    ranks.sample
  end

  def include?(rank)
    ranks.include?(rank)
  end

  def cards_same_rank(rank)
    cards.select { |card| card.rank == rank }
  end

  def to_s
    cards.join(', ')
  end

  private

  def ranks
    cards.map(&:rank)
  end

end
