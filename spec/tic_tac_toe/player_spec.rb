require 'spec_helper'

describe TicTacToe::Player do
  let(:player) { described_class.new('X') }

  describe '#marker' do
    it 'should return the player\'s marker character' do
      expect(player.marker).to eq('X')
    end
  end
end
