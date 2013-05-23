require './board.rb'
require './pieces.rb'
require './chess_player.rb'
require 'debugger'


class Game


  def initialize(player1, player2, board)
    @turn = :white
    @players = {
      :white => player1,
      :black => player2
    }
    @board = board
  end


  def play_loop
    until @board.checkmate?(@turn)

      play_turn
    end
  end

  def self.lets_play
    board = Board.new
    player_1 = Player.new(board)
    player_2 = Player.new(board)
    game = Game.new(player_1, player_2, board)
    game.play_loop
  end


  private

  def play_turn
    while true
      puts "#{@turn}"
      @board.display
      current_player = @players[@turn]
      start_pos, end_pos = current_player.turn(@turn)

      break if @board.move_piece(start_pos, end_pos) #this should return true if the move worked
      puts "Invalid move. Try again."
    end

    @turn = ((@turn == :white) ? :black : :white)
  end



end


if __FILE__ == $PROGRAM_NAME
  Game.lets_play
end