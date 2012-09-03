require 'spec_helper'

describe GameController do

  describe :index do
    it "should generate a new puzzle if the session is empty" do
      Game.should_receive(:generate_puzzle).and_return(mock(:game, :puzzle => [1, 2, 4, 5]))

      session.delete(:game)
      get :index
    end

    it "should load the puzzle if it was stored in the session" do
      session[:game] = {:puzzle => [1, 2, 4, 6]}
      get :index

      controller.instance_variable_get('@game').puzzle.should == [1, 2, 4, 6]
    end
  end

  describe :bet do
    it "should store the first bet in the session and redirect to index" do
      session[:game] = {}
      post :bet, '0' => '2', '1' => '3', '2' => '6', '3' => '5'

      session[:game][:bets].should == [[2, 3, 6, 5]]
      response.should be_redirect
    end

    it "should add more bets to the existing ones" do
      session[:game] = {}
      session[:game][:bets] = [[2, 3, 6, 5]]
      post :bet, '0' => '4', '1' => '2', '2' => '6', '3' => '5'

      session[:game][:bets].should == [[2, 3, 6, 5], [4, 2, 6, 5]]
    end
  end

  describe :reset do
    it "should reset the game in the session and redirect to index" do
      session[:game] = "foo bar baz"
      delete :reset

      session[:game].should be_blank
      response.should be_redirect
    end
  end

end
