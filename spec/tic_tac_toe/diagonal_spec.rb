require 'spec_helper'

describe TicTacToe::Diagonal do
  let(:diagonal) { described_class.new('top_left', ['O', 'X', nil, 'O']) }

  it 'should extend TicTacToe::Sequence' do
    expect(diagonal).to be_a(TicTacToe::Sequence)
  end

  describe '#origin' do
    it 'should return its assigned origin' do
      expect(diagonal.origin).to eq('top_left')
    end
  end

  describe '#board_coordinates' do
    context 'with a character included its values' do
      context 'with a top_left origin' do
        let(:diagonal) { described_class.new('top_left', ['O', 'X', nil, 'O']) }

        it 'should return an array' do
          expect(diagonal.board_coordinates(nil)).to be_an(Array)
        end

        it 'should return the index of the first occurence of character as the first element in the array' do
          expect(diagonal.board_coordinates(nil)[0]).to eq(2)
        end

        it 'should return the index of the first occurence of character as the second element in the array' do
          expect(diagonal.board_coordinates(nil)[1]).to eq(2)
        end
      end

      context 'with a bottom_left origin' do
        let(:diagonal) { described_class.new('bottom_left', ['O', 'X', nil, 'O']) }

        it 'should return an array' do
          expect(diagonal.board_coordinates(nil)).to be_an(Array)
        end

        it 'should return ((size - 1) - index of the first occurence of character) as the first element in the array' do
          expect(diagonal.board_coordinates(nil)[0]).to eq(1)
        end

        it 'should return the index of the first occurence of character as the second element in the array' do
          expect(diagonal.board_coordinates(nil)[1]).to eq(2)
        end
      end
    end

    context 'with a character not included its values' do
      it 'should return nil' do
        expect(diagonal.board_coordinates('Z')).to be_nil
      end
    end
  end
end
