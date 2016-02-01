require 'spec_helper'

describe TicTacToe::Column do
  let(:column) { described_class.new(1, [nil, 'X', 'O']) }

  it 'should extend TicTacToe::Sequence' do
    expect(column).to be_a(TicTacToe::Sequence)
  end

  describe '#index' do
    it 'should return its assigned index' do
      expect(column.index).to eq(1)
    end
  end

  describe '#board_coordinates' do
    context 'with a character included its values' do
      it 'should return an array' do
        expect(column.board_coordinates('O')).to be_an(Array)
      end

      it 'should return the index of the first occurence of character as the first element in the array' do
        expect(column.board_coordinates('O')[0]).to eq(2)
      end

      it 'should return it\'s own index as the second element in the array' do
        expect(column.board_coordinates('O')[1]).to eq(1)
      end
    end

    context 'with a character not included its values' do
      it 'should return nil' do
        expect(column.board_coordinates('Z')).to be_nil
      end
    end
  end
end
