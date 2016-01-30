module TicTacToe
  class CLI
    def process_input(prompt, allowed: [], disallowed: [])
      if allowed.length > 0
        process_input_allowed(prompt, allowed)
      elsif disallowed.length > 0
        process_input_disallowed(prompt, disallowed)
      else
        collect_input(prompt)
      end
    end

    def parse_move
      input = process_input('Coordinates (X/Y)')
      unless input =~ move_coordinates_format
        raise InvalidMoveError, 'Invalid format (must match: X,Y)'
      end

      input.split(',').map(&:to_i)
    end

    def puts(text)
      STDOUT.puts(text)
    end

    def board_string
      [
        " X  #{(1..board.size).to_a.join('   ')}",
        "Y",
        board_row_strings
      ].flatten.join("\n")
    end

    def print_board
      STDOUT.puts(board_string)
    end

    private

    attr_accessor :board

    def collect_input(prompt)
      STDOUT.print("#{prompt}: ")
      STDIN.gets.strip
    end

    def process_input_allowed(prompt, allowed)
      loop do
        input = collect_input("#{prompt} [#{allowed.join('/')}]")
        if allowed.include?(input)
          return input
        else
          STDOUT.puts("Invalid response: #{input}")
        end
      end
    end

    def process_input_disallowed(prompt, disallowed)
      loop do
        input = collect_input(prompt)
        if disallowed.include?(input)
          STDOUT.puts("Invalid response: #{input}")
        else
          return input
        end
      end
    end

    def board_row_strings
      board.spaces.map.with_index do |row, i|
        "#{i + 1}   #{row.join(' | ')}"
      end.join(board_row_divider)
    end

    def board_row_divider
      "\n    #{"---" * board.size}\n"
    end

    def move_coordinates_format
      /\A\d+,\d+\z/
    end
  end
end
