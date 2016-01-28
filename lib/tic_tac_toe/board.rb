module TicTacToe
  class Board
    attr_accessor :spaces
    attr_reader   :size

    def initialize(size: 3)
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

    def winning_marker
      complete = complete_sequence
      complete[0] unless complete.nil?
    end

    private

    def rows
      spaces
    end

    def columns
      (0...size).each_with_object([]) do |i, cols|
        cols << rows.collect { |row| row[i] }
      end
    end

    def diagonals
      top_left = (0...size).each_with_object([]) { |i, d| d << spaces[i][i] }
      bottom_left = (0...size).each_with_object([]) { |i, d| d << spaces[(size - 1) - i][i] }
      [top_left, bottom_left]
    end

    # Returns all of the complete sequences of spaces
    def sequences
      rows + columns + diagonals
    end

    # Returns the first sequence with identical (non-nil) markers
    def complete_sequence
      sequences.find { |s| s == s.compact && s.uniq.count == 1 }
    end

    def valid_space?(row_index, column_index)
      if invalid_space?(row_index, column_index)
        raise TicTacToe::InvalidMoveError, 'Invalid row/column'
      elsif occupied_space?(row_index, column_index)
        raise TicTacToe::InvalidMoveError, 'This space is occupied'
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
