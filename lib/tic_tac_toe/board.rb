module TicTacToe
  class Board
    attr_accessor :spaces
    attr_reader   :size

    def initialize(size = 3)
      @size = size
      @spaces = empty_spaces
    end

    def place_marker(row_index, column_index, marker)
      if valid_space?(row_index, column_index)
        spaces[row_index][column_index] = marker
      end
    end

    def full?
      spaces.flatten.none? { |space| space.nil? }
    end

    private

    def valid_space?(row_index, column_index)
      if invalid_space?(row_index, column_index)
        raise InvalidMoveError, 'Invalid row/column'
      elsif occupied_space?(row_index, column_index)
        raise InvalidMoveError, 'This space is occupied'
      else
        true
      end
    end

    def invalid_space?(row_index, column_index)
      !(row_index.between?(0, size - 1) && column_index.between?(0, size - 1))
    end

    def occupied_space?(row_index, column_index)
      !(spaces[row_index][column_index].nil?)
    end

    def empty_spaces
      Array.new(size).fill(Array.new(size))
    end
  end
end
