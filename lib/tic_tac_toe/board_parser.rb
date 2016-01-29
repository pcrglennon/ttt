module TicTacToe
  class BoardParser
    attr_reader :spaces

    def initialize(spaces)
      @spaces = spaces
      @board_size = spaces.size
    end

    def winning_marker
      complete = complete_sequence
      complete[0] unless complete.nil?
    end

    private

    attr_reader :board_size

    # Returns the first sequence with identical (non-nil) markers
    def complete_sequence
      sequences.find { |s| s == s.compact && s.uniq.count == 1 }
    end

    # Returns all of the complete sequences of spaces
    def sequences
      rows + columns + diagonals
    end

    def rows
      spaces
    end

    def columns
      (0...board_size).each_with_object([]) do |i, cols|
        cols << rows.collect { |row| row[i] }
      end
    end

    def diagonals
      [top_left_diagonal, top_right_diagonal]
    end

    def top_left_diagonal
      (0...board_size).each_with_object([]) { |i, d| d << spaces[i][i] }
    end

    def top_right_diagonal
      (0...board_size).each_with_object([]) { |i, d| d << spaces[(board_size - 1) - i][i] }
    end
  end
end
