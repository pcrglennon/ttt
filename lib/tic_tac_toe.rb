require "tic_tac_toe/version"
require "tic_tac_toe/board"
require "tic_tac_toe/cli"

module TicTacToe
  class InvalidMoveError < StandardError; end
end
