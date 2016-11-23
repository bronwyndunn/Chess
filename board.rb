require_relative "piece"
require 'byebug'
require_relative "display"
require_relative 'rook'
require_relative "queen"
require_relative "bishop"
require_relative "king"
require_relative "knight"
require_relative "pawn"

class Board

  attr_reader :grid
  attr_accessor :display

  def initialize()
    @grid = make_starting_grid
    @display = Display.new(self)

  end

  def update()
    while true
      @display.render(@grid)
    end
  end

  def [](pos)
    x ,y = pos
    @grid[x][y]
  end


  def move_piece(start_pos, end_pos)
      raise "You cant move there!" unless in_bounds?(end_pos)
      piece = self[start_pos]
      raise "No pieces here!!" if piece.nil?
      piece.position = end_pos
      self[start_pos] = NilPiece.instance()
      self[end_pos] = piece

  end

  def make_starting_grid
    grid = Array.new(8) {Array.new(8) }
      grid[0][0] = Rook.new([0,0], :white, self)
      grid[0][1] = Knight.new([0,1], :white, self)
      grid[0][2] = Bishop.new([0,2], :white, self)
      grid[0][3] = King.new([0,3], :white, self)
      grid[0][4] = Queen.new([0,4], :white, self)
      grid[0][5] = Bishop.new([0,5], :white, self)
      grid[0][6] = Knight.new([0,6], :white, self)
      grid[0][7] = Rook.new([0,7], :white, self)
      8.times do |y|
        grid[1][y] = Pawn.new([1,y], :white, self)
      end

      8.times do |y|
        grid[6][y] = Pawn.new([6,y], :black, self)
      end
      grid[7][0] = Rook.new([7,0], :black, self)
      grid[7][1] = Knight.new([7,1], :black, self)
      grid[7][2] = Bishop.new([7,2], :black, self)
      grid[7][3] = King.new([7,3], :black, self)
      grid[7][4] = Queen.new([7,4], :black, self)
      grid[7][5] = Bishop.new([7,5], :black, self)
      grid[7][6] = Knight.new([7,6], :black, self)
      grid[7][7] = Rook.new([7,7], :black, self)
    [2,3,4,5].each do |x|
      8.times do |y|
        grid[x][y] = NilPiece.instance()
      end
    end
    grid
  end

  def in_bounds?(pos)
    pos.all? do |cord|
      cord.between?(0,7)
    end
  end

  def[](pos)
    x ,y = pos
    @grid[x][y]
  end

  def []=(pos,val)
    x,y = pos
    @grid[x][y] = val
  end

  def in_check?(color)
    pieces = grid.flatten
    king = pieces.find {|piece| piece.class == King && piece.color == color}
    king_pos = king.position

    other_color = color == :white ? :black : :white
    other_pieces = pieces.select {|piece| piece.color == other_color}
    other_pieces.any? {|piece| piece.moves(self).include?(king_pos) }
  end

  def checkmate?(color)
    pieces = grid.flatten.select {|piece| piece.color == color }
    in_check = in_check?(color)
    pieces.each do |piece|
      p piece
      puts piece.valid_moves(self)
    end
  end

  def dup
    duped_board = Board.new
    8.times do |x|
      8.times do |y|
        pos = [x,y]
        cur_piece = self[pos]
        if cur_piece.class == NilPiece
          duped_board[pos] = cur_piece.class.instance()
        else
          duped_board[pos] = cur_piece.class.new(pos, cur_piece.color, duped_board)
        end
      end
    end
    duped_board
  end
end

board = Board.new
board.move_piece([6,1], [4,1])
board.move_piece([6,2], [4,2])
board.move_piece([0,4], [4,0])
board.display.render(board.grid)
p board.checkmate?(:black)
