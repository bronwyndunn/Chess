require_relative 'piece'
require_relative 'stepable'

class Knight < Piece
  include Stepable
  def set_symbol
    sym = "♘" if @color == :white
    sym = "♞" if @color == :black
    sym
  end
  def move_dirs
    [:knight]
  end

end
