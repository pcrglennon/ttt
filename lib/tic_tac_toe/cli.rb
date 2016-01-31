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

      input.split(',').map{ |i| i.to_i - 1 }
    end

    def puts(text)
      STDOUT.puts(text)
    end

    def board_string(rows)
      [
        " X  #{(1..rows.size).to_a.join('   ')}",
        "Y",
        board_row_strings(rows)
      ].flatten.join("\n")
    end

    def print_board(rows)
      STDOUT.puts(board_string(rows))
    end

    private

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

    def board_row_strings(rows)
      rows.map.with_index do |row, i|
        "#{i + 1}   #{row.join(' | ')}"
      end.join(board_row_divider(rows.length))
    end

    def board_row_divider(length)
      "\n    #{"---" * length}\n"
    end

    def move_coordinates_format
      /\A\d+,\d+\z/
    end
  end
end
