module TicTacToe
  class GameRunner
    attr_accessor :players, :current_player, :board
    attr_reader :cli

    def initialize
      @players = []
      @cli = CLI.new
    end

    def run
      cli.puts(welcome_message)
      initialize_players
      loop do
        new_game!
        play_game
        break unless play_again?
      end
      cli.puts(goodbye_message)
    end

    def initialize_players
      players << Player.new(1, 'X')
      players << initialize_player_two
      @current_player = players[0]
    end

    def new_game!
      size = cli.process_input('Choose board size', allowed: (3..9))
      @board = Board.new(size.to_i)
      @current_player = players[0]
    end

    def play_game
      until game_over?
        cli.print_board(board.spaces)
        next_move
      end
      print_game_result
    end

    def game_over?
      board.full? || game_winner != nil
    end

    def game_winner
      winning_marker = parser.winning_marker
      winning_marker && players.find { |p| p.marker == winning_marker }
    end

    def next_move
      begin
        column, row = cli.parse_move(current_player)
        board.place_marker(row, column, current_player.marker)
        toggle_current_player
      rescue InvalidMoveError => e
        cli.puts("\n#{e.message}")
      end
    end

    def play_again?
      response = cli.process_input('Play Again?', allowed: ['Y', 'N'])
      response != 'N'
    end

    private

    def parser
      BoardParser.new(board.spaces)
    end

    def toggle_current_player
      @current_player = current_player == players[0] ? players[1] : players[0]
    end

    def initialize_player_two
      response = cli.process_input('Choose Opponent', allowed: ['Computer', 'Human'])
      if response == 'Human'
        Player.new(2, 'O')
      else
        ComputerPlayer.new(2, 'O', players[0].marker)
      end
    end

    def print_game_result
      cli.puts(game_result_message)
      cli.print_board(board.spaces)
    end

    def welcome_message
      "\nWelcome to TicTacToe v0.1.0\n"
    end

    def goodbye_message
      "\nGoodbye!\n\n"
    end

    def game_result_message
      game_winner != nil ? game_winner_message : draw_game_message
    end

    def game_winner_message
      "\n\nVictory to #{game_winner.formatted}!"
    end

    def draw_game_message
      "\n\nDraw Game!"
    end
  end
end
