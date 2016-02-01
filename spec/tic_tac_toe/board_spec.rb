require 'spec_helper'

describe TicTacToe::Board do
  let(:board) { described_class.new }

  describe 'constructor' do
    context 'with a size argument' do
      it 'should set the board\'s size to the value of the argument' do
        expect(described_class.new(4).size).to eq(4)
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
      let(:draw_game_board) { build(:draw_game_board) }

      it 'should return true' do
        expect(draw_game_board.full?).to be_truthy
      end
    end

    context 'with available spaces' do
      let(:incomplete_board) { build(:incomplete_board) }

      it 'should return false' do
        expect(incomplete_board.full?).to be_falsy
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
      it 'should raise a TicTacToe::InvalidMoveError' do
        expect{ board.place_marker(0, 2, 'x') }.to raise_error(TicTacToe::InvalidMoveError, 'Space at [3,1] is occupied')
      end
    end

    context 'with invalid coordinates' do
      it 'should raise a TicTacToe::InvalidMoveError' do
        expect{ board.place_marker(5, 8, 'x') }.to raise_error(TicTacToe::InvalidMoveError, 'Invalid coordinates [9,6]')
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
