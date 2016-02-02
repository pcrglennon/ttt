module TicTacToe
  class ComputerPlayer < TicTacToe::Player
    attr_reader :opponent_marker

    def initialize(id, marker, opponent_marker)
      @opponent_marker = opponent_marker
      super(id, marker)
    end

    def next_move(spaces)
      @parser = BoardParser.new(spaces)
      winning_move || blocking_move || random_move
    end

    private

    attr_reader :parser

    def winning_move
      sequence = incomplete_winning_sequence(marker)
      sequence && sequence.board_coordinates(nil)
    end

    def blocking_move
      sequence = incomplete_winning_sequence(opponent_marker)
      sequence && sequence.board_coordinates(nil)
    end

    def random_move
      row = random_row
      column_index = random_column_index(row)
      [row.index, column_index]
    end

    def incomplete_winning_sequence(marker)
      parser.sequences.find { |seq| seq.count(marker) == parser.board_size - 1 }
    end

    def random_row
      available_rows = parser.rows.reject { |r| r.complete? }
      available_rows.sample
    end

    def random_column_index(row)
      available_indices = row.values.each_index.select { |i| row.values[i].nil? }
      available_indices.sample
    end
  end
end
