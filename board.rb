class Board

  attr_reader :squares
  #Maybe initialize pieces when we generate the board, put pieces where they need to start

  COL_HASH = {a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7}


  #EXAMPLE MOVE
  #pos= f4 #player enters postion
  #[(4-1), col_hash[f]]   reverse order, subtract one from
                          #row to match index, pull value from COL_HASH

  def initialize(players)
    @squares = generate_squares
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

  def check?(king)
    all_possible_moves = []
    @squares.each do |row|
      row.each do |piece|
        unless piece.nil? || piece.color == king.color
          all_possible_moves += piece.possible_moves
        end
      end
    end
    all_possible_moves.include?(king.location)
  end


  def checkmate?


  end

  private
    def generate_squares
      squares = []
      8.times do |row_index|
        squares << []
        8.times do |column_index|
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
