require 'spec_helper'

describe TicTacToe::Sequence do
  let(:sequence) { described_class.new([nil, 'X', 'O']) }

  describe '#values' do
    it 'should return its values' do
      expect(sequence.values).to eq([nil, 'X', 'O'])
    end
  end

  describe '#size' do
    it 'should return the size of its values' do
      expect(sequence.size).to eq(3)
    end
  end

  describe '#complete?' do
    context 'with a complete set of identical values' do
      let(:sequence) { described_class.new(['X', 'X', 'X']) }

      it 'should return truthy' do
        expect(sequence.complete?).to be_truthy
      end
    end

    context 'with a complete set of non-identical values' do
      let(:sequence) { described_class.new(['X', 'X', 'O']) }

      it 'should return false' do
        expect(sequence.complete?).to be_falsy
      end
    end

    context 'with a incomplete set of values' do
      let(:sequence) { described_class.new(['X', 'X', nil]) }

      it 'should return false' do
        expect(sequence.complete?).to be_falsy
      end
    end
  end

  describe '#count' do
    let(:sequence) { described_class.new(['X', 'X', 'O']) }

    it 'should return the count of the given character in its values' do
      expect(sequence.count('X')).to eq(2)
      expect(sequence.count('O')).to eq(1)
      expect(sequence.count(nil)).to eq(0)
    end
  end

  describe '#index_of' do
    context 'with a character included its values' do
      it 'should return the index of the first occurence of that character' do
        expect(sequence.index_of('X')).to eq(1)
      end
    end

    context 'with a character not included its values' do
      it 'should return nil' do
        expect(sequence.index_of('Z')).to be_nil
      end
    end
  end
end
