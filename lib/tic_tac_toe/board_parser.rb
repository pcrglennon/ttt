module TicTacToe
  class BoardParser
    attr_reader :spaces

    def initialize(spaces)
      @spaces = spaces
    end

    # Returns all of the complete sequences of spaces
    def sequences
      @sequences ||= rows + columns + diagonals
    end

    def rows
      @rows ||= spaces.map.with_index { |values, i| Row.new(i, values) }
    end

    def columns
      @columns ||= (0...board_size).each_with_object([]) do |i, cols|
        values = spaces.collect { |values| values[i] }
        cols << Column.new(i, values)
      end
    end

    def diagonals
      @diagonals ||= [top_left_diagonal, bottom_left_diagonal]
    end

    def winning_marker
      complete = complete_sequence
      complete.values[0] unless complete.nil?
    end

    private

    def board_size
      spaces.size
    end

    def complete_sequence
      sequences.find { |s| s.complete? }
    end

    def top_left_diagonal
      values = (0...board_size).each_with_object([]) do
        |i, d| d << spaces[i][i]
      end
      Diagonal.new('top_left', values)
    end

    def bottom_left_diagonal
      values = (0...board_size).each_with_object([]) do
        |i, d| d << spaces[(board_size - 1) - i][i]
      end
      Diagonal.new('bottom_left', values)
    end
  end
end
