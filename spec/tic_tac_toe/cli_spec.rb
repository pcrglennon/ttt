require 'spec_helper'

describe TicTacToe::CLI do
  let(:cli) { described_class.new }

  describe '#process_input' do
    before do
      allow(STDOUT).to receive(:print)
      allow(STDIN).to receive(:gets) { "1,0  \n" }
    end

    it 'should format and print the prompt over STDOUT' do
      cli.process_input('Coordinates')

      expect(STDOUT).to have_received(:print).with('Coordinates: ')
    end

    it 'should return the normalized user input' do
      expect(cli.process_input('Coordinates')).to eq('1,0')
    end
  end

  describe '#parse_move' do
    it 'should parse the user input into row & column indices' do
      allow(cli).to receive(:process_input) { '1,0' }

      expect(cli.parse_move).to eq([1, 0])
    end

    context 'with invalid format' do
      it 'should raise a TicTacToe::InvalidMoveError' do
        allow(cli).to receive(:process_input) { 'invalid,20,50' }

        expect{ cli.parse_move }.to raise_error(TicTacToe::InvalidMoveError, 'Invalid format (must match: X,Y)')
      end
    end
  end

  describe '#board_string' do
    let(:board) { TicTacToe::Board.new }

    before do
      allow(STDOUT).to receive(:print)

      board.spaces = [['x', 'o', 'x'],
                      ['o', 'x', 'o'],
                      ['o', 'x', 'x']]
    end

    it 'should return a formatted representation of the board' do
      board_string = <<-BOARD
        X 1   2   3
      Y   ---------
      1   x | o | x
      2   o | x | o
      3   o | x | x
      BOARD

      expect(cli.board_string(board)).to match(board_string)
    end
  end
end
