require './lib/game'

class GoFish
  def initialize
    Game.new.play
  end
end

GoFish.new
