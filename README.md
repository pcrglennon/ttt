# TicTacToe

A barebones TicTacToe console application.

## Usage

To start the application:

```sh
$ bundle install
$ chmod u+x bin/run
$ ./bin/run
```

## Testing

The test suite is built using `rspec` and `factory-girl`, which will be installed via the `bundle install` step above.

## Notes

You can play against another person, or against a semi-intelligent computer opponent.

The size of the board is configurable between 3x3 and 9x9, and at the start of each game you will be prompted to set the size.

The game loop itself is simple (psuedocode):

```
until game_is_over?
  make_next_move
end
output_game_result
```

The game is over when the board is full, or a winner is detected.  To check for the latter, the `BoardParser` class looks at each _n_-length sequence on the board.  That is, each row, each column, and the two _n_-length diagonals:

```
X | X | X    |   |      |   |    X |   |      | X |      |   | X  X |   |      |   | X
---------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
  |   |    X | X | X    |   |    X |   |      | X |      |   | X    | X |      | X |
---------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
  |   |      |   |    X | X | X  X |   |      | X |      |   | X    |   | X  X |   |

```

If any of them are completely filled by one marker, the owner of that marker is the winner.

The computer opponent plays like so:

* If there is an open square that would win the game, place marker there
* Otherwise, if there is an open square that would block the opponent from winning, place marker there
* Otherwise, place marker on a random open square

To determine whether there is a winning/blocking move available, it utilizes the `BoardParser` class to look at all the _n_-length sequences, and check if any are one marker away from being a winning sequence.

## Future Improvements

* Randomize which player gets to make first move
* Improve the computer opponent to be able to play perfectly, using the MiniMax algorithm.
  * And allow ability to disable this, so that one can actually win a game!
* Re-use logic in a visual application, and use clicks instead of entering coordinates
