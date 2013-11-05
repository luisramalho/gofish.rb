require_relative 'card'
require 'forwardable'

class Deck
  extend Forwardable

  def_delegators :@cards, :pop, :empty?, :shuffle!, :count

  SUITS = %w{ H D S C }
  RANKS = %w{ 2 3 4 5 6 7 8 9 10 J Q K A }

  attr_reader :cards

  def initialize
    @cards = []
    seed
    shuffle!
  end

  def include_rank?(rank)
    RANKS.include?(rank)
  end

  private

  def seed
    SUITS.product(RANKS) do |suit, rank|
      cards << Card.new(suit: suit, rank: rank)
    end
  end

end
