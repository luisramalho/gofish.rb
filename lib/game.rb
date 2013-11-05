# encoding: utf-8

require_relative 'deck'
require_relative 'hand'
require_relative 'player'
require_relative 'output'

class Game

  attr_reader :deck, :user, :computer, :output
  attr_accessor :current_player, :opponent, :players

  def initialize
    @deck = Deck.new
    @user = Player.new(
      name: 'Luís',
      hand: Hand.new(deck.cards.pop(7).sort!)
    )
    @computer = Player.new(
      name: 'Computer',
      hand: Hand.new(deck.cards.pop(7).sort!)
    )
    @output = Output.new
    @current_player = user
    @opponent = computer
  end

  def play
    output.logo
    set_player_roles(user, computer)
    game_loop until game_over?
  end

  def game_loop
    output.options(user) if current_player == user
    opponent_has?(rank_picked)
    discard_pairs(current_player)
    swap_roles
  end

  def rank_picked
    if current_player == user
      rank = gets.chomp
      return invalid_rank? unless user.hand.include?(rank)
    else
      rank = computer.hand.random_rank
      output.rank_requested(name(current_player), rank)
    end
    rank
  end

  def invalid_rank?
    output.invalid_rank
    game_loop
  end

  def swap_roles
    if current_player == user
      set_player_roles(computer, user)
    else
      set_player_roles(user, computer)
    end
  end

  def discard_pairs(current_player)
    discarded_pairs = discard_pairs_from(current_player)
    return unless discarded_pairs
    output.pairs_discarded(name(current_player), discarded_pairs)
  end

  def set_player_roles(curr, op)
    @current_player = curr
    @opponent = op
  end

  def opponent_has?(rank)
    go_fish unless opponent.hand.include?(rank)
    cards_same_rank(opponent, rank).each do |card|
      transfer_card(opponent, card, current_player)
      output.cards_transferred(name(current_player), card, name(opponent))
    end
  end

  def go_fish
    return game_over? if deck.empty?
    card = deck.pop
    current_player.cards << card
    output.go_fish(name(current_player), card)
  end

  def game_over?
    return false unless someone_empty?
    output.game_over
    output.game_winner(compare_pairs)
    output.game_results(user, computer)
    play_again?
  end

  def compare_pairs
    number_of_pairs(computer) <=> number_of_pairs(user)
  end

  def someone_empty?
    deck.empty? ||
    computer.cards.empty? ||
    user.cards.empty?
  end

  def name(player)
    player.name
  end

  def player_has_rank?(player, rank)
    player.hand.include?(rank)
  end

  def empty_hand?(player)
    player.cards.empty?
  end

  def cards_same_rank(player, rank)
    player.hand.cards_same_rank(rank)
  end

  def number_of_pairs(player)
    player.pairs.count
  end

  def discard_pairs_from(player)
    player.discard_pairs
  end

  def transfer_card(player, card, current_player)
    player.transfer(card, current_player)
  end

  def play_again?
    output.play_again?
    case gets.chomp
    when 'y'
      Game.new.play
    else
      exit
    end
  end

  at_exit { 'Thanks for playing! Goodbye.' }

end
