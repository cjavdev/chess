
require './pieces.rb'
class Board

  attr_accessor :squares, :active_pieces
  #Maybe initialize pieces when we generate the board, put pieces where they need to start




  #EXAMPLE MOVE
  #pos= f4 #player enters postion
  #[(4-1), col_hash[f]]   reverse order, subtract one from
                          #row to match index, pull value from COL_HASH

  def initialize(squares = self.class.blank_squares)
    @squares = squares
    @active_pieces = {:white => [], :black => []}
    Piece.place_pieces(self)
  end


  def [](row, col)
    @squares[row][col]
  end

  def []=(row, col, piece)
    old_row, old_col = piece.location
    @squares[old_row][old_col] = nil

    taken = @squares[row][col]
    if taken
      taken.location = nil
      @active_pieces[taken.color].delete(taken)
    end

    @squares[row][col] = piece
    piece.location = [row, col]
  end

  def self.in_board?(position)
    position.all? {|coord| coord.between?(0, 7)}
  end

  def move_piece(start_pos, end_pos) #should return true if the move was valid
    #debugger
    piece = self[*start_pos]
    unless piece.nil?
      if piece.valid_move?(end_pos)
        self[*end_pos] = piece
        return true
      end
    end
    false
  end

  def check?(king)
    all_possible_destinations(king.color).include?(king.location)
  end


  def checkmate?(color)
    @active_pieces[color].each do |piece|
     current_moves = piece.possible_moves
      current_moves.each do |move|
        ghost_board = self.clone_board
        ghost_king = ghost_board.king(color)
        ghost_board.move_piece(piece.location, move)
        return false unless ghost_board.check?(ghost_king)
      end
    end
    true
  end


  def clone_board
    #debugger
    ghost_board = self.clone
    ghost_board.squares = @squares.map do |row|
      row.map do |piece|
        unless piece.nil?
          piece.clone
        end
      end
    end

    set_clone_pieces(ghost_board)
    ghost_board
  end

  def set_clone_pieces(ghost_board)
    ghost_board.squares.each do |row|
      row.each do |piece|
        piece.board = ghost_board unless piece.nil?
      end
    end
    ghost_board
  end

  def all_possible_destinations(color)
    all_possible_destinations = []
    @active_pieces[color].each do |piece|
      all_possible_destinations += piece.possible_moves
    end
    all_possible_destinations
  end

  def king(color)
    @active_pieces[color].each do |piece|
      return piece if piece.king?
    end
  end

  def display
    @squares.each do |row|
      p row
    end
  end

  # private
  def self.blank_squares
    squares = []
    8.times do |row_index|
      squares << []
      8.times do
        squares[row_index] << nil
      end
    end
    squares
  end
end