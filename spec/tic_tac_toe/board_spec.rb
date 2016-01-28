require 'spec_helper'

describe TicTacToe::Board do
  let(:board) { described_class.new }

  describe 'constructor' do
    context 'with a size argument' do
      it 'should set the board\'s size to the value of the argument' do
        expect(described_class.new(size: 4).size).to eq(4)
      end
    end

    context 'without a size argument' do
      it 'should set the board\'s size to 3' do
        expect(described_class.new.size).to eq(3)
      end
    end
  end

  describe '#full?' do
    context 'with no available spaces' do
      before do
        board.spaces = [['x', 'o', 'x'],
                        ['o', 'x', 'o'],
                        ['o', 'x', 'x']]
      end

      it 'should return true' do
        expect(board.full?).to be_truthy
      end
    end

    context 'with available spaces' do
      before do
        board.spaces = [['x', nil, 'o'],
                        [nil, 'x', nil],
                        ['o', 'o', 'x']]
      end

      it 'should return false' do
        expect(board.full?).to be_falsy
      end
    end
  end

  describe '#winning_marker' do
    context 'with a complete row of one marker' do
      before do
        board.spaces = [['x', 'x', 'x'],
                        [nil, 'o', nil],
                        ['o', 'o', nil]]
      end

      it 'should return that marker' do
        expect(board.winning_marker).to eq('x')
      end
    end

    context 'with a complete column of one marker' do
      before do
        board.spaces = [['x', nil, 'o'],
                        ['x', 'x', nil],
                        ['x', 'o', 'o']]
      end

      it 'should return that marker' do
        expect(board.winning_marker).to eq('x')
      end
    end

    context 'with a complete diagonal of one marker' do
      context 'from the top-left to the bottom-right' do
        before do
          board.spaces = [['x', nil, 'o'],
                          [nil, 'x', nil],
                          ['o', 'x', 'x']]
        end

        it 'should return that marker' do
          expect(board.winning_marker).to eq('x')
        end
      end

      context 'from the bottom-left to the top-right' do
        before do
          board.spaces = [['o', 'o', 'x'],
                          [nil, 'x', nil],
                          ['x', 'o', 'x']]
        end

        it 'should return that marker' do
          expect(board.winning_marker).to eq('x')
        end
      end
    end

    context 'without a complete row, column, or diagonal of one marker' do
      before do
        board.spaces = [['x', 'x', 'o'],
                        ['o', 'x', 'x'],
                        ['x', 'o', 'o']]
      end

      it 'should return nil' do
        expect(board.winning_marker).to be_nil
      end
    end
  end

  describe '#place_marker' do
    before do
      board.spaces = [['x', nil, 'o'],
                      [nil, 'x', nil],
                      ['o', 'o', 'x']]
    end

    context 'on an occupied space' do
      it 'should throw a TicTacToe::InvalidMoveError' do
        expect{ board.place_marker(0, 0, 'x') }.to raise_error(TicTacToe::InvalidMoveError, 'This space is occupied')
      end
    end

    context 'with invalid coordinates' do
      it 'should throw a TicTacToe::InvalidMoveError' do
        expect{ board.place_marker(5, 8, 'x') }.to raise_error(TicTacToe::InvalidMoveError, 'Invalid row/column')
      end
    end

    context 'on an open space' do
      it 'should place the marker in that space' do
        board.place_marker(0, 1, 'x')

        expect(board.spaces[0][1]).to eq('x')
      end
    end
  end
end
