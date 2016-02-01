module TicTacToe
  class Diagonal < Sequence
    attr_reader :origin

    def initialize(origin, values)
      @origin = origin
      super(values)
    end

    def board_coordinates(character)
      self.send("#{origin}_board_coordinates", character)
    end

    private

    def top_left_board_coordinates(character)
      character_index = index_of(character)
      [character_index, character_index] if character_index
    end

    def bottom_left_board_coordinates(character)
      character_index = index_of(character)
      [(size - 1 - character_index), character_index] if character_index
    end
  end
end
