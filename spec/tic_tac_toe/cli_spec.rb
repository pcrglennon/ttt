require 'spec_helper'

describe TicTacToe::CLI do
  let(:cli) { described_class.new }

  describe '#process_input' do
    before do
      allow(STDOUT).to receive(:print)
      allow(STDOUT).to receive(:puts)
      allow(STDIN).to receive(:gets) { "foobar  \n" }
    end

    it 'should format and print the prompt over STDOUT' do
      cli.process_input('Response')

      expect(STDOUT).to have_received(:print).with(/Response: /)
    end

    it 'should return the normalized user input' do
      expect(cli.process_input('Response')).to eq('foobar')
    end

    context 'with allowed responses' do
      let(:allowed_responses) { ['Y', 'N'] }

      it 'should include the allowed responses in the prompt' do
        allow(STDIN).to receive(:gets) { "Y \n" }

        cli.process_input('Response', allowed: allowed_responses)

        expect(STDOUT).to have_received(:print).with(/Response \[Y\/N\]: /)
      end

      context 'when input is not in the allowed responses' do
        before do
          allow(STDIN).to receive(:gets).and_return("X  \n", "Y \n")
          cli.process_input('Response', allowed: allowed_responses)
        end

        it 'should print an error message' do
          expect(STDOUT).to have_received(:puts).with(/Invalid response: X/)
        end

        it 'should repeat the prompt' do
          expect(STDOUT).to have_received(:print).with(/Response \[Y\/N\]: /).twice
        end
      end
    end
  end

  describe '#parse_move' do
    let(:player) { build(:player_one) }

    it 'should prompt the current player to enter their move' do
      allow(cli).to receive(:process_input) { '3,2' }

      cli.parse_move(player)

      expect(cli).to have_received(:process_input).with("#{player.formatted} - Enter coordinates")
    end

    it 'should parse the user input into zero-indexed row & column indices' do
      allow(cli).to receive(:process_input) { '3,2' }

      expect(cli.parse_move(player)).to eq([2, 1])
    end

    context 'with invalid format' do
      it 'should raise a TicTacToe::InvalidMoveError' do
        allow(cli).to receive(:process_input) { 'invalid,20,50' }

        expect{ cli.parse_move(player) }.to raise_error(TicTacToe::InvalidMoveError, 'Invalid format (must match: X,Y)')
      end
    end
  end

  describe '#puts' do
    before { allow(STDOUT).to receive(:puts) }

    it 'should call STDIN.puts' do
      cli.puts('foobar')

      expect(STDOUT).to have_received(:puts).with('foobar')
    end
  end

  describe '#board_string' do
    let(:board) do
      TicTacToe::Board.new.tap do |b|
       b.spaces = [['x', 'o', 'x'],
                   ['o', 'x', 'o'],
                   ['o', 'x', 'x']]
      end
    end
    let(:board_string) do
      <<-BOARD
       X  1   2   3
      Y
      1   x | o | x
          ---------
      2   o | x | o
          ---------
      3   o | x | x
      BOARD
    end

    it 'should return a formatted representation of the board' do
      expect(cli.board_string(board.spaces)).to match(board_string)
    end
  end

  describe '#print_board' do
    let(:board) { build(:board) }

    it 'should print out the board with spacing above and below' do
      allow(STDOUT).to receive(:puts)
      board_string = cli.board_string(board.spaces)

      cli.print_board(board.spaces)

      expect(STDOUT).to have_received(:puts).with("\n#{board_string}\n")
    end
  end
end
