require 'spec_helper'

describe Game do

  subject { Game.generate_puzzle }

  describe :generate_puzzle do

    it "should generate a puzzle" do
      subject.puzzle.should be_a Array
      subject.puzzle.size.should == 4
      subject.puzzle.each do |value|
        value.should be_a Fixnum
        value.should be >= 1
        value.should be <= Game::MAX
      end
    end

    it "should have random numbers" do
      games = (1..5).map do
        Game.generate_puzzle.puzzle
      end.uniq

      games.size.should be > 1
    end

    it "should have distinct values" do
      5.times do
        Game.generate_puzzle.puzzle.uniq.size.should == 4
      end
    end

  end

  describe :make_bet do

    it "should return [4,0] on the correct bet" do
      subject.make_bet(subject.puzzle).should == [4, 0]
    end

    it "should return [0,0] when the bet is totally wrong" do
      #subject.make_bet(subject.puzzle.map { |x| x % Game::MAX + 1 }).should == [0, 0]
      subject.make_bet([-1, -1, -1, -1]).should == [0, 0]
    end

    it "should return the correct result" do
      subject.puzzle = [ 1, 2, 4, 5 ]
      subject.make_bet([ 1, 2, 5, 3]).should == [2, 1]
    end

  end

end
