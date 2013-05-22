require 'board.rb'
require 'pieces.rb'
require 'chess_player.rb'



class Game


  def initialize(player1, player2)
    @turn = :white
    @players = {
      :white => player1,
      :black => player2
    }
    @board = Board.new(@players)
  end


  def play_loop
    until @board.checkmate?
      play_turn
    end
  end

  def self.lets_play
    player_1 = Player.new
    player_2 = Player.new
    game = Game.new(player_1, player_2)
    game.play_loop
  end


  private

  def play_turn
    while true
      current_player = @players[@turn]
      start_pos, end_pos = current_player.turn

      break if @board.move_piece(start_pos, end_pos) #this should return true if the move worked
      puts "Invalid move. Try again."
    end

    @turn = ((@turn == :white) ? :black : :white)
  end



end


Game.lets_play