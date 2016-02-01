require 'spec_helper'

describe TicTacToe::ComputerPlayer do
  let(:player) { build(:computer_player) }

  it 'should extend TicTacToe::Player' do
    expect(player).to be_a(TicTacToe::Player)
  end

  describe '#next_move' do
    context 'with an opportunity to win the game' do
      let(:spaces) do
        [[nil, nil, 'X'],
         ['O', 'X', nil],
         ['O', 'X', nil]]
      end

      it 'should return the coordinates of the space to win' do
        expect(player.next_move(spaces)).to eq([0,0])
      end
    end

    context 'with an opportunity to block opponent from winning' do
      let(:spaces) do
        [['O', nil, nil],
         ['X', nil, 'X'],
         ['O', 'X', nil]]
      end

      it 'should return the coordinates of the space to block' do
        expect(player.next_move(spaces)).to eq([1,1])
      end
    end

    context 'otherwise' do
      let(:spaces) do
        [['O', nil, nil],
         ['X', nil, nil],
         [nil, 'X', nil]]
      end

      before do
        allow(player).to receive(:winning_move).and_return(nil)
        allow(player).to receive(:blocking_move).and_return(nil)

        row = TicTacToe::Row.new(1, spaces[1])
        allow(player).to receive_message_chain(:parser, :rows, :reject, :sample)
          .and_return(row)
        allow(row).to receive_message_chain(:values, :each_index, :select, :sample)
          .and_return(2)
      end

      it 'should return the coordinates of a random open space' do
        expect(player.next_move(spaces)).to eq([1,2])
      end
    end
  end
end
