
require 'debugger'
class Board

  attr_accessor :squares
  #Maybe initialize pieces when we generate the board, put pieces where they need to start

  COL_HASH = {a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7}


  #EXAMPLE MOVE
  #pos= f4 #player enters postion
  #[(4-1), col_hash[f]]   reverse order, subtract one from
                          #row to match index, pull value from COL_HASH

  def initialize(squares = self.class.blank_squares)
    @squares = squares
    @active_pieces = {:white => [], :black => []}
  end


  def [](row, col)
    @squares[row][col]
  end

  def []=(row, col, piece)
    old_row, old_col = piece.location
    @squares[old_row][old_col] = nil
    @squares[row][col] = piece
  end

  def self.in_board?(position)
    position.all? {|coord| c.between?(0, 7)}
  end

  def move_piece(start_pos, end_pos) #should return true if the move was valid
    piece = self[*start_pos]
    unless piece.nil?
      return piece.valid_move?(end_pos)
    end
    false
  end

  def check?(king)
    all_possible_moves.include?(king.location)
  end


  def checkmate?(king)
    @active_pieces[king.color].each do |piece|
     current_moves = piece.possible_moves
      current_moves.each do |move|
        ghost_board = self.clone_board
        ghost_king = ghost_board.king(king.color)
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

  def all_possible_moves(color)
    all_possible_moves = []
    @squares.each do |row|
      row.each do |piece|
        unless piece.nil? || piece.color == color
          all_possible_moves += piece.possible_moves
        end
      end
    end
    all_possible_moves
  end

  def king(color)
    @active_pieces[color].each do |piece|
      return piece if piece.king?
    end
  end
#   def dup
#     self.dup
#     # debugger
# #     duped = @squares.map(&:dup)
# #     @squares.each_with_index do |row, index|
# #        duped[index] = row.map do |pos|
# #          pos.dup unless pos.nil?
# #        end
# #     end
#   end

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


# class Square
#
#   #get rid of this, unneccessary. Make sure to change references in pieces classes
#
#
#   attr_accessor :occupied,
#   attr_reader :location, :neighbors
#   attr_writer :occupied_by
#   alias_method :occupied?, :occupied
#
#   def initialize(location)
#     @location = location
#     @neighbors = Hash.new { nil }
#     @occupied_by = nil
#   end
#
#   def set_neighbors
#     row, col  = @location
#
#     DELTAS.each do |key, value|
#       new_row = value[0] + row
#       new_col = value[1] + col
#
#       if Square.in_board? ([new_row, new_col])
#         @neighbors[key] = [new_row, new_col]
#       end
#     end
#   end
#
#   def occupied_by
#     return self.occupied_by unless self.occupied_by.nil?
#     nil
#   end
#
#   def self.in_board?(coord)
#     coord.all? {|c| c.between?(0, 7)}
#   end
#
# end
