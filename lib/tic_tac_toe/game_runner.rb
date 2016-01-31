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
      @current_player = players.first
    end

    def new_game!
      @board = Board.new
      @current_player = players.first
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

    def toggle_current_player
      if current_player == players.first
        @current_player = players.last
      else
        @current_player = players.first
      end
    end

    def initialize_player_two
      response = cli.process_input('Choose Opponent: ', allowed: ['Computer', 'Human'])
      response == 'Human' ? Player.new('O') : ComputerPlayer.new('O')
    end
  end
end
