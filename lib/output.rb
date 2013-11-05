class Output

  def logo
    p '##########################################'
    p '#           Welcome to Go Fish!          #'
    p '##########################################'
  end

  def options(user)
    p user
    p 'Which card do you want?'
  end

  def invalid_rank
    p 'You must have rank requested.'
  end

  def rank_requested(name, rank)
    # sleep 2
    p "#{name} wants a #{rank}."
  end

  def pairs_discarded(name, discarded_pairs)
    discarded_pairs.each do |pair|
      puts "* #{name} discarded #{pair.first} & #{pair.last}"
      # sleep 1
    end
  end

  def cards_transferred(name, card, other_player_name)
    # sleep 2
    puts "#{name} got #{card} from #{other_player_name}"
    # sleep 2
  end

  def go_fish(name, card)
    # sleep 2
    p 'Go Fish!'
    # sleep 3
    p "#{name} got #{card} from the deck"
    # sleep 2
  end

  def game_over
    p "\n* Game Over *"
  end

  def game_results(user, computer)
    p "You got #{pluralize(user.pairs.count, 'pair')}"
    p "Computer got #{pluralize(computer.pairs.count, 'pair')}"
  end

  def game_winner(winner)
    p case winner
      when 1
        'Computer Won!'
      when 0
        'You draw!'
      when -1
        'You Won!'
      end
  end

  def play_again?
    p "\nWant to play again? (y/n)"
  end

  def pluralize(n, singular, plural = nil)
    if n == 1
      "1 #{singular}"
    elsif plural
      "#{n} #{plural}"
    else
      "#{n} #{singular}s"
    end
  end

  def p(message)
    puts message
  end
end
