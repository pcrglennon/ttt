module TicTacToe
  class CLI
    def process_input(prompt)
      STDOUT.print("#{prompt}: ")
      STDIN.gets.strip
    end

    def parse_move
      input = process_input('Coordinates (X/Y)')
      unless input =~ move_coordinates_format
        raise InvalidMoveError, 'Invalid format (must match: X,Y)'
      end

      input.split(',').map(&:to_i)
    end

    def board_string(board)
      [
        "  X  #{(1..board.size).to_a.join('   ')}",
        "Y    #{Array.new(board.size).fill('---').join('')}"
      ].concat(board_row_strings(board)).join("\n")
    end

    def print_board(board)
      STDOUT.puts(board_string)
    end

    private

    def board_row_strings(board)
      board.spaces.map.with_index do |row, i|
        "#{i + 1}    #{row.join(' | ')}"
      end
    end

    def move_coordinates_format
      /\A\d+,\d+\z/
    end
  end
end
