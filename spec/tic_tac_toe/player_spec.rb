require 'spec_helper'

describe TicTacToe::Player do
  let(:player) { described_class.new(1, 'X') }

  describe '#id' do
    it 'should return the player\'s ID' do
      expect(player.id).to eq(1)
    end
  end

  describe '#marker' do
    it 'should return the player\'s marker character' do
      expect(player.marker).to eq('X')
    end
  end

  describe '#formatted' do
    it 'should return a formatted string with the player\'s ID and marker' do
      expect(player.formatted).to eq('Player 1 (X)')
    end
  end
end
