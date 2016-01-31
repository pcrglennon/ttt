module TicTacToe
  class GameRunner
    attr_accessor :players, :current_player, :board
    attr_reader :cli

    def initialize
      @players = []
      @cli = CLI.new
    end

    def initialize_players
      players << Player.new('X')
      players << initialize_player_two
      @current_player = players[0]
    end

    def new_game!
      @board = Board.new
      @current_player = players[0]
    end

    def game_over?
      game_winner || board.full?
    end

    def next_move
      begin
        row, column = cli.parse_move
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

    def game_winner
      parser.winning_marker != nil
    end

    def toggle_current_player
      @current_player = current_player == players[0] ? players[1] : players[0]
    end

    def initialize_player_two
      response = cli.process_input('Choose Opponent: ', allowed: ['Computer', 'Human'])
      response == 'Human' ? Player.new('O') : ComputerPlayer.new('O')
    end
  end
end
