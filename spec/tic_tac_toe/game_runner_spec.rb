require 'spec_helper'

describe TicTacToe::GameRunner do
  let(:runner) { described_class.new }

  describe '#initialize_players' do
    before { allow(runner.cli).to receive(:process_input).and_return('Human') }

    it 'should create Player One' do
      runner.initialize_players

      expect(runner.players[0]).to be_a(TicTacToe::Player)
    end

    it 'should create Player One with an \'X\' marker' do
      runner.initialize_players

      expect(runner.players[0].marker).to eq('X')
    end

    context 'with a human opponent selected' do
      before do
        allow(runner.cli).to receive(:process_input).and_return('Human')
        runner.initialize_players
      end

      it 'should create Player Two' do
        expect(runner.players[1]).to be_a(TicTacToe::Player)
      end

      it 'should create Player Two with an \'O\' marker' do
        expect(runner.players[1].marker).to eq('O')
      end
    end

    context 'with a computer opponent selected' do
      before do
        allow(runner.cli).to receive(:process_input).and_return('Computer')
        runner.initialize_players
      end

      it 'should create a computer Player Two' do
        expect(runner.players[1]).to be_a(TicTacToe::ComputerPlayer)
      end

      it 'should create a computer Player Two with an \'O\' marker' do
        expect(runner.players[1].marker).to eq('O')
      end

      it 'should create a computer Player Two with an \'X\' opponent_marker' do
        expect(runner.players[1].opponent_marker).to eq('X')
      end
    end
  end

  describe '#new_game!' do
    let(:players) { [build(:player_one), build(:player_two)] }

    before do
      runner.players = players
      runner.current_player = players[1]
      runner.board = build(:draw_game_board)
      runner.new_game!
    end

    it 'should create a new, empty board' do
      expect(runner.board.spaces).to match_array(TicTacToe::Board.new.spaces)
    end

    it 'should set Player One as the current player' do
      expect(runner.current_player).to eq(players[0])
    end
  end

  describe '#play_game' do
    before do
      runner.board = build(:empty_board)
      allow(runner).to receive(:game_over?).and_return(*([false] * 5), true)
      allow(runner.cli).to receive(:print_board)
      allow(runner).to receive(:next_move)
      allow(runner).to receive(:print_game_result)
      runner.play_game
    end

    it 'should prompt for the next move until the game is over' do
      expect(runner).to have_received(:next_move).exactly(5).times
    end

    it 'should print the current state of the board before each move' do
      expect(runner.cli).to have_received(:print_board).exactly(5).times
    end

    it 'should print the result of the game' do
      expect(runner).to have_received(:print_game_result)
    end
  end

  describe '#game_over?' do
    context 'with a game which resulted in a draw' do
      before { runner.board = build(:draw_game_board) }

      it 'should return true' do
        expect(runner.game_over?).to be_truthy
      end
    end

    context 'with a game which has been won' do
      before do
        runner.players = [build(:player_one), build(:player_two)]
        runner.board = build(:x_winner_board)
      end

      it 'should return true' do
        expect(runner.game_over?).to be_truthy
      end
    end

    context 'with an incomplete game' do
      before { runner.board = build(:incomplete_board) }

      it 'should return false' do
        expect(runner.game_over?).to be_falsy
      end
    end

    context 'with a new game' do
      before { runner.board = build(:empty_board) }

      it 'should return false' do
        expect(runner.game_over?).to be_falsy
      end
    end
  end

  describe '#game_winner' do
    let(:player_one) { build(:player_one) }
    let(:player_two) { build(:player_two) }

    before { runner.players = [player_one, player_two] }

    context 'with a game which resulted in a draw' do
      before { runner.board = build(:draw_game_board) }

      it 'should return nil' do
        expect(runner.game_winner).to be_nil
      end
    end

    context 'with a game which has been won by Player One' do
      before { runner.board = build(:x_winner_board) }

      it 'should return Player One' do
        expect(runner.game_winner).to eq(player_one)
      end
    end

    context 'with a game which has been won by Player Two' do
      before { runner.board = build(:o_winner_board) }

      it 'should return Player Two' do
        expect(runner.game_winner).to eq(player_two)
      end
    end

    context 'with an incomplete game' do
      before { runner.board = build(:incomplete_board) }

      it 'should return nil' do
        expect(runner.game_winner).to be_nil
      end
    end
  end

  describe '#next_move' do
    let(:players) { [build(:player_one), build(:player_two)] }

    before do
      runner.players = players
      runner.current_player = players[0]
      runner.new_game!
    end

    it 'should prompt the current player to make their move' do
      allow(runner.cli).to receive(:parse_move).and_return([1, 1])
      runner.next_move

      expect(runner.cli).to have_received(:parse_move)
    end

    context 'with a valid move' do
      before do
        allow(runner.cli).to receive(:parse_move).and_return([0, 0])
      end

      it 'should place the current player\'s marker on the designated spot' do
        expect {
          runner.next_move
        }.to change{ runner.board.spaces[0][0] }.from(nil).to(players[0].marker)
      end

      it 'should toggle the current player' do
        expect {
          runner.next_move
        }.to change{ runner.current_player }.from(players[0]).to(players[1])
      end
    end

    context 'with an invalid move' do
      before do
        allow(runner.cli).to receive(:puts)
        allow(runner.cli).to receive(:parse_move).and_raise(TicTacToe::InvalidMoveError, 'Foobar')
      end

      it 'should place the current player\'s marker' do
        expect {
          runner.next_move
        }.to_not change{ runner.board.spaces }
      end

      it 'should should not toggle the current player' do
        expect {
          runner.next_move
        }.to_not change{ runner.current_player }
      end

      it 'should log the error message' do
        runner.next_move

        expect(runner.cli).to have_received(:puts).with(/Foobar/)
      end
    end
  end

  describe '#play_again?' do
    context 'with user input "N"' do
      before { allow(runner.cli).to receive(:process_input).and_return('N') }

      it 'should return false' do
        expect(runner.play_again?).to be_falsy
      end
    end

    context 'with other user input' do
      before { allow(runner.cli).to receive(:process_input).and_return('Y') }

      it 'should return truthy' do
        expect(runner.play_again?).to be_truthy
      end
    end
  end

  describe '#run' do
    before do
      allow(runner).to receive(:initialize_players)
      allow(runner).to receive(:new_game!)
      allow(runner).to receive(:play_game)
      allow(runner).to receive(:play_again?).and_return(false)

      allow(runner.cli).to receive(:puts)
      runner.run
    end

    it 'should print a welcome message' do
      expect(runner.cli).to have_received(:puts).with(/Welcome to TicTacToe v0\.1\.0/)
    end

    it 'should initialize the players' do
      expect(runner).to have_received(:initialize_players)
    end

    it 'should start a new game' do
      expect(runner).to have_received(:new_game!)
      expect(runner).to have_received(:play_game)
    end

    context 'when another game is requested' do
      before { allow(runner).to receive(:play_again?).and_return(true) }

      it 'should start a new game' do
        expect(runner).to have_received(:new_game!)
        expect(runner).to have_received(:play_game)
      end
    end

    context 'when another game is not requested' do
      it 'should print a goodbye message' do
        expect(runner.cli).to have_received(:puts).with(/Goodbye!/)
      end
    end
  end
end
