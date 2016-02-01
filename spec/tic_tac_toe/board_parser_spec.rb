require 'spec_helper'

describe TicTacToe::BoardParser do
  let(:spaces) do
    [['x', 'x', 'x'],
     [nil, 'o', nil],
     ['o', 'o', nil]]
   end

  let(:parser) { described_class.new(spaces) }

  describe '#rows' do
    it 'should return an array of TicTacToe::Row objects' do
      expect(parser.rows).to satisfy do |rows|
        rows.each { |row| row.is_a?(TicTacToe::Row) }
      end
    end

    it 'should return the rows of the board' do
      expect(parser.rows).to satisfy do |rows|
        rows[0].index == 0 && rows[0].values == ['x', 'x', 'x']
        rows[1].index == 1 && rows[1].values == [nil, 'o', nil]
        rows[2].index == 2 && rows[2].values == ['o', 'o', nil]
      end
    end
  end

  describe '#columns' do
    it 'should return an array of TicTacToe::Column objects' do
      expect(parser.columns).to satisfy do |columns|
        columns.each { |column| column.is_a?(TicTacToe::Column) }
      end
    end

    it 'should return the columns of the board' do
      expect(parser.columns).to satisfy do |columns|
        columns[0].index == 0 && columns[0].values == ['x', nil, 'o']
        columns[1].index == 1 && columns[1].values == ['x', 'o', 'o']
        columns[2].index == 2 && columns[2].values == ['x', nil, nil]
      end
    end
  end

  describe '#diagonals' do
    it 'should return an array of TicTacToe::Diagonal objects' do
      expect(parser.diagonals).to satisfy do |diagonals|
        diagonals.each { |diagonal| diagonal.is_a?(TicTacToe::Diagonal) }
      end
    end

    it 'should return the two diagonal sequences of the board' do
      expect(parser.diagonals).to satisfy do |diagonals|
        diagonals[0].origin == 'top_left' && diagonals[0].values == ['x', 'o', nil]
        diagonals[1].origin == 'bottom_left' && diagonals[1].values == ['o', 'o', 'x']
      end
    end
  end

  describe '#sequences' do
    it 'should return the rows, columns, and diagonals' do
      expect(parser.sequences).to eq(parser.rows + parser.columns + parser.diagonals)
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
