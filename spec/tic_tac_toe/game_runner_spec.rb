require 'spec_helper'

describe TicTacToe::GameRunner do
  let(:runner) { described_class.new }
  let(:draw_game_board) do
    TicTacToe::Board.new.tap do |board|
      board.spaces = [['X', 'O', 'X'],
                      ['O', 'X', 'O'],
                      ['O', 'X', 'X']]
    end
  end
  let(:x_winner_board) do
    TicTacToe::Board.new.tap do |board|
      board.spaces = [[nil, 'X', nil],
                      ['O', 'X', 'O'],
                      ['O', 'X', 'X']]
    end
  end
  let(:incomplete_board) do
    TicTacToe::Board.new.tap do |board|
      board.spaces = [[nil, 'O', nil],
                      ['X', 'X', nil],
                      ['O', 'X', 'O']]
    end
  end
  let(:empty_board) { TicTacToe::Board.new }
  let(:players) { [TicTacToe::Player.new('X'), TicTacToe::Player.new('O')] }

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

    it 'should create Player Two' do
      runner.initialize_players

      expect(runner.players[1]).to be_a(TicTacToe::Player)
    end

    it 'should create Player Two with an \'O\' marker' do
      runner.initialize_players

      expect(runner.players[1].marker).to eq('O')
    end

    context 'with a computer opponent selected' do
      before { allow(runner.cli).to receive(:process_input).and_return('Computer') }

      it 'should create a computer Player Two' do
        runner.initialize_players

        expect(runner.players[1]).to be_a(TicTacToe::ComputerPlayer)
      end
    end
  end

  describe '#new_game!' do
    before do
      runner.players = players
      runner.current_player = players[1]
      runner.board = draw_game_board
      runner.new_game!
    end

    it 'should create a new, empty board' do
      expect(runner.board.spaces).to match_array(TicTacToe::Board.new.spaces)
    end

    it 'should set Player One as the current player' do
      expect(runner.current_player).to eq(players[0])
    end
  end

  describe '#game_over?' do
    context 'with a game which resulted in a draw' do
      before { runner.board = draw_game_board }

      it 'should return true' do
        expect(runner.game_over?).to be_truthy
      end
    end

    context 'with a game which has been won' do
      before { runner.board = x_winner_board }

      it 'should return true' do
        expect(runner.game_over?).to be_truthy
      end
    end

    context 'with an incomplete game' do
      before { runner.board = incomplete_board }

      it 'should return false' do
        expect(runner.game_over?).to be_falsy
      end
    end
  end

  describe '#next_move' do
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

        expect(runner.cli).to have_received(:puts).with('Foobar')
      end
    end
  end
end
