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
        raise InvalidMoveError, "Invalid coordinates #{humanize_indices(row_index, column_index)}"
      elsif occupied_space?(row_index, column_index)
        raise InvalidMoveError, "Space at #{humanize_indices(row_index, column_index)} is occupied"
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

    # Output indices for error message in the format the user entered them
    def humanize_indices(row_index, column_index)
      "[#{column_index + 1},#{row_index + 1}]"
    end

    def empty_spaces
      (0...size).each_with_object([]) do |i, arr|
        arr[i] = Array.new(size)
      end
    end
  end
end
