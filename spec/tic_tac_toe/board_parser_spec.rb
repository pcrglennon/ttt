require 'spec_helper'

describe TicTacToe::BoardParser do
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
