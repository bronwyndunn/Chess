require "singleton"
require "byebug"
class Piece

  attr_accessor :position, :color, :board, :symbol

  def initialize(pos, color, board)
    @position = pos
    @color = color
    @symbol = set_symbol

  end

  def valid_moves(board)
    moves = self.moves(board)
    valid_moves_arr = []
    moves.each do |move|
      board_dup = board.dup
      board_dup.move_piece(@position, move)
      unless board_dup.in_check?(@color)
        valid_moves_arr << move
      end
    end
    valid_moves_arr
  end

  def to_s
    return "P"
  end
end

class NilPiece < Piece
  include Singleton
  def initialize
    @color = :transparent
    @symbol = " "
  end
  def to_s
    "_"
  end

end
