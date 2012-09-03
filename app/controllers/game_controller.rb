class GameController < ApplicationController

  # GET /index
  def index
    session[:game] ||= {}

    if session[:game][:puzzle]
      @game = Game.new
      @game.puzzle = session[:game][:puzzle]
    else
      @game = Game.generate_puzzle
      session[:game][:puzzle] = @game.puzzle
    end

    @bets = session[:game][:bets] || []
  end

  # POST /bet
  def bet
    session[:game][:bets] ||= []
    session[:game][:bets] << %w(0 1 2 3).map { |param| params[param].to_i }

    redirect_to index_path
  end

  # DELETE /reset
  def reset
    session.delete(:game)

    redirect_to index_path
  end
end
