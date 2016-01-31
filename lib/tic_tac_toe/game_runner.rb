module TicTacToe
  class GameRunner
    attr_accessor :players, :current_player, :board
    attr_reader :cli

    def initialize
      @players = []
      @cli = CLI.new
    end

    def initialize_players
      players << Player.new(1, 'X')
      players << initialize_player_two
      @current_player = players[0]
    end

    def new_game!
      @board = Board.new
      @current_player = players[0]
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
        column, row = cli.parse_move
        board.place_marker(row, column, current_player.marker)
        toggle_current_player
      rescue InvalidMoveError => e
        cli.puts(e.message)
      end
    end

    private

    def parser
      BoardParser.new(board.spaces)
    end

    def toggle_current_player
      @current_player = current_player == players[0] ? players[1] : players[0]
    end

    def print_result
      if game_winner.nil?
        cli.puts(game_winner_message)
      else
        cli.puts(draw_game_message)
      end
      cli.print_board(board.spaces)
    end

    def game_winner_message
      "Victory to #{game_winner.formatted}!"
    end

    def draw_game_message
      "Draw Game!"
    end

    def initialize_player_two
      response = cli.process_input('Choose Opponent', allowed: ['Computer', 'Human'])
      response == 'Human' ? Player.new(2, 'O') : ComputerPlayer.new(2, 'O')
    end
  end
end
