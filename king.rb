require_relative 'piece'
require_relative 'stepable'

class King < Piece
  include Stepable


  def set_symbol
    sym = "♔" if @color == :white
    sym = "♚" if @color == :black
    sym
  end
  def move_dirs
    [:king]
  end

end
