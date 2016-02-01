module TicTacToe
  class Row < Sequence
    attr_reader :index

    def initialize(index, values)
      @index = index
      super(values)
    end

    def board_coordinates(character)
      character_index = index_of(character)
      [index, character_index] if character_index
    end
  end
end
