require 'spec_helper'

describe TicTacToe::Row do
  let(:row) { described_class.new(0, [nil, 'X', 'O']) }

  it 'should extend TicTacToe::Sequence' do
    expect(row).to be_a(TicTacToe::Sequence)
  end

  describe '#index' do
    it 'should return its assigned index' do
      expect(row.index).to eq(0)
    end
  end

  describe '#board_coordinates' do
    context 'with a character included its values' do
      it 'should return an array' do
        expect(row.board_coordinates('O')).to be_an(Array)
      end

      it 'should return it\'s own index as the first element in the array' do
        expect(row.board_coordinates('O')[0]).to eq(0)
      end

      it 'should return the index of the first occurence of character as the second element in the array' do
        expect(row.board_coordinates('O')[1]).to eq(2)
      end
    end

    context 'with a character not included its values' do
      it 'should return nil' do
        expect(row.board_coordinates('Z')).to be_nil
      end
    end
  end
end
