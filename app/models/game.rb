class Game

  MAX = 6

  attr_accessor :puzzle

  class << self

    def generate_puzzle
      self.new.tap do |game|
        begin
          game.puzzle = (1..4).map { rand(1..MAX) }
        end while game.puzzle.uniq.size < 4
      end
    end

  end

  def make_bet(bet)
    result = [0, 0]
    bet.each_with_index do |value, index|
      if value == @puzzle[index]
        result[0] += 1
      elsif @puzzle.include?(value)
        result[1] += 1
      end
    end
    result
  end

end
