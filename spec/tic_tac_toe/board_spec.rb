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
      before do
        allow(board).to receive(:spaces) do
          [['x', 'o', 'x'],
           ['o', 'x', 'o'],
           ['o', 'x', 'x']]
        end
      end

      it 'should return true' do
        expect(board.full?).to be_truthy
      end
    end

    context 'with available spaces' do
      before do
        allow(board).to receive(:spaces) do
          [['x', nil, 'o'],
           [nil, 'x', nil],
           ['o', 'o', 'x']]
        end
      end

      it 'should return false' do
        expect(board.full?).to be_falsy
      end
    end
  end

  describe '#winning_character' do
    context 'with a complete row of one character' do
      before do
        allow(board).to receive(:spaces) do
          [['x', 'x', 'x'],
           [nil, 'o', nil],
           ['o', 'o', nil]]
        end
      end

      it 'should return that character' do
        expect(board.winning_character).to eq('x')
      end
    end

    context 'with a complete column of one character' do
      before do
        allow(board).to receive(:spaces) do
          [['x', nil, 'o'],
           ['x', 'x', nil],
           ['x', 'o', 'o']]
        end
      end

      it 'should return that character' do
        expect(board.winning_character).to eq('x')
      end
    end

    context 'with a complete diagonal of one character' do
      context 'from the top-left to the bottom-right' do
        context 'with an odd size' do
          before do
            allow(board).to receive(:spaces) do
              [['x', nil, 'o'],
               [nil, 'x', nil],
               ['o', 'x', 'x']]
            end
          end

          it 'should return that character' do
            expect(board.winning_character).to eq('x')
          end
        end

        context 'with an even size' do
          let (:board) { described_class.new(4) }

          before do
            allow(board).to receive(:spaces) do
              [['x', nil, 'o', 'o'],
               [nil, 'x', nil, 'o'],
               ['o', 'x', 'x', 'x'],
               ['o', 'o', 'x', 'x']]
            end
          end

          it 'should return that character' do
            expect(board.winning_character).to eq('x')
          end
        end
      end

      context 'from the bottom-left to the top-right' do
        context 'with an odd size' do
          before do
            allow(board).to receive(:spaces) do
              [['o', 'o', 'x'],
               [nil, 'x', nil],
               ['x', 'o', 'x']]
            end
          end

          it 'should return that character' do
            expect(board.winning_character).to eq('x')
          end
        end

        context 'with an even size' do
          let (:board) { described_class.new(4) }

          before do
            allow(board).to receive(:spaces) do
              [['o', 'o', 'o', 'x'],
               ['x', nil, 'x', nil],
               ['o', 'x', 'o', 'x'],
               ['x', 'o', 'x', 'o']]
            end
          end

          it 'should return that character' do
            expect(board.winning_character).to eq('x')
          end
        end
      end
    end

    context 'without a complete row, column, or diagonal of one character' do
      before do
        allow(board).to receive(:spaces) do
          [['x', 'x', 'o'],
           ['o', 'x', 'x'],
           ['x', 'o', 'o']]
        end
      end

      it 'should return nil' do
        expect(board.winning_character).to be_nil
      end
    end
  end
end
