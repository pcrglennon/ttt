module TicTacToe
  class Column < Sequence
    attr_reader :index

    def initialize(index, values)
      @index = index
      super(values)
    end

    def board_coordinates(character)
      character_index = index_of(character)
      [character_index, index] if character_index
    end
  end
end
