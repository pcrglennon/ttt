require 'spec_helper'

describe TicTacToe::BoardParser do
  let(:spaces) do
    [['x', 'x', 'x'],
     [nil, 'o', nil],
     ['o', 'o', nil]]
   end

  let(:parser) { described_class.new(spaces) }

  describe '#rows' do
    it 'should return the rows of the board' do
      expect(parser.rows).to match_array([['x', 'x', 'x'], [nil, 'o', nil], ['o', 'o', nil]])
    end
  end

  describe '#columns' do
    it 'should return the columns of the board' do
      expect(parser.columns).to match_array([['x', nil, 'o'], ['x', 'o', 'o'], ['x', nil, nil]])
    end
  end

  describe '#diagonals' do
    it 'should return the two diagonal sequences of the board' do
      expect(parser.diagonals).to match_array([['x', 'o', nil], ['o', 'o', 'x']])
    end
  end

  describe '#sequences' do
    it 'should return the rows, columns, and diagonals' do
      expect(parser.sequences).to match_array(parser.rows + parser.columns + parser.diagonals)
    end
  end

  describe '#winning_marker' do
    context 'with a complete row of one marker' do
      let(:parser) do
        spaces = [['x', 'x', 'x'],
                  [nil, 'o', nil],
                  ['o', 'o', nil]]
        described_class.new(spaces)
      end

      it 'should return that marker' do
        expect(parser.winning_marker).to eq('x')
      end
    end

    context 'with a complete column of one marker' do
      let(:parser) do
        spaces = [['x', nil, 'o'],
                  ['x', 'x', nil],
                  ['x', 'o', 'o']]
        described_class.new(spaces)
      end

      it 'should return that marker' do
        expect(parser.winning_marker).to eq('x')
      end
    end

    context 'with a complete diagonal of one marker' do
      context 'from the top-left to the bottom-right' do
        let(:parser) do
          spaces = [['x', nil, 'o'],
                    [nil, 'x', nil],
                    ['o', 'x', 'x']]
          described_class.new(spaces)
        end

        it 'should return that marker' do
          expect(parser.winning_marker).to eq('x')
        end
      end

      context 'from the bottom-left to the top-right' do
        let(:parser) do
          spaces = [['o', 'o', 'x'],
                    [nil, 'x', nil],
                    ['x', 'o', 'x']]
          described_class.new(spaces)
        end

        it 'should return that marker' do
          expect(parser.winning_marker).to eq('x')
        end
      end
    end

    context 'without a complete row, column, or diagonal of one marker' do
      let(:parser) do
        spaces = [['x', 'x', 'o'],
                  ['o', 'x', 'x'],
                  ['x', 'o', 'o']]
        described_class.new(spaces)
      end

      it 'should return nil' do
        expect(parser.winning_marker).to be_nil
      end
    end
  end
end
