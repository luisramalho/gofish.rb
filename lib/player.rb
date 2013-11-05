class Player

  attr_accessor :name, :hand, :pairs, :discarded_pairs

  def initialize(args)
    @name = args[:name] || 'User'
    @hand = args[:hand]
    @pairs = []
  end

  def discard_pairs
    @discarded_pairs = []
    i = (hand.sort!.count - 1)
    while i > 0
      if cards[i] == cards[i - 1]
        discarded_pairs << slice_pair(i)
        i -= 1
      end
      i -= 1
    end
    return if discarded_pairs.empty?
    pairs.push(*discarded_pairs)
    discarded_pairs
  end

  def slice_pair(i)
    [cards.slice!(i), cards.slice!(i - 1)]
  end

  def transfer(card, other_player)
    other_player.hand << card
    hand.delete(card)
  end

  def cards
    hand.cards
  end

  def to_s
    output = Output.new
    sprintf(
      "\n%-10s | %-8s | %-8s | %s\n\n",
      name,
      output.pluralize(pairs.count, 'pair'),
      output.pluralize(cards.count, 'card'),
      hand
    )
  end

end
