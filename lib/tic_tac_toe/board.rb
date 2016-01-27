module TicTacToe
  class Board
    attr_reader :size, :spaces

    def initialize(size = 3)
      @size = size
      @spaces = empty_spaces
    end

    def full?
      spaces.flatten.none? { |space| space.nil? }
    end

    def winning_character
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

    # Returns the first sequence with identical (non-nil) characters
    def complete_sequence
      sequences.find { |s| s == s.compact && s.uniq.count == 1 }
    end

    def empty_spaces
      Array.new(size).fill(Array.new(size))
    end
  end
end
