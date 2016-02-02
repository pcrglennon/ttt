module TicTacToe
  class CLI
    def process_input(prompt, allowed: [])
      if allowed.to_a.length > 0
        process_input_allowed(prompt, allowed)
      else
        collect_input(prompt)
      end
    end

    def parse_move(player)
      input = process_input("#{player.formatted} - Enter coordinates")
      unless input =~ move_coordinates_format
        raise InvalidMoveError, 'Invalid format (must match: X,Y)'
      end

      input.split(',').map{ |i| i.to_i }
    end

    def puts(text)
      STDOUT.puts(text)
    end

    def board_string(rows)
      [
        " X   #{(1..rows.size).to_a.join('   ')}",
        "Y",
        board_row_strings(rows)
      ].flatten.join("\n")
    end

    def print_board(rows)
      STDOUT.puts("\n#{board_string(rows)}\n")
    end

    private

    def collect_input(prompt)
      STDOUT.print("\n#{prompt}: ")
      STDIN.gets.strip
    end

    def process_input_allowed(prompt, allowed)
      loop do
        input = collect_input(allowed_prompt_message(prompt, allowed))
        if allowed_input?(allowed, input)
          return input
        else
          STDOUT.puts("Invalid response: #{input}")
        end
      end
    end

    def allowed_input?(allowed, input)
      if allowed.is_a?(Range)
        allowed.include?(parse_numeric_input(input))
      else
        allowed.include?(input)
      end
    end

    def parse_numeric_input(input)
      begin
        Float(input)
      rescue ArgumentError
        false
      end
    end

    def allowed_prompt_message(prompt, allowed)
      if allowed.is_a?(Array)
        "#{prompt} [#{allowed.join('/')}]"
      else
        "#{prompt} [#{allowed.to_s}]"
      end
    end

    def board_row_strings(rows)
      rows.map.with_index do |row, i|
        "#{i + 1}   #{board_row_string(row)}"
      end.join(board_row_divider(rows.length))
    end

    def board_row_string(row)
      " #{row.map { |marker| marker.nil? ? ' ' : marker }.join(' | ')} "
    end

    def board_row_divider(length)
      divider_string = ("----" * length)[0...-1]
      "\n    #{divider_string}\n"
    end

    def move_coordinates_format
      /\A\d+,\d+\z/
    end
  end
end
