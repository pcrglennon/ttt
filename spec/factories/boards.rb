FactoryGirl.define do
  factory :board, class: TicTacToe::Board do
    skip_create

    factory :empty_board

    factory :incomplete_board do
      spaces [[nil, 'O', nil],
              ['O', 'X', 'O'],
              [nil, 'X', 'X']]
    end

    factory :draw_game_board do
      spaces [['X', 'O', 'X'],
              ['O', 'X', 'O'],
              ['O', 'X', 'X']]
    end

    factory :x_winner_board do
      spaces [[nil, 'X', nil],
              ['O', 'X', 'O'],
              ['O', 'X', 'X']]
    end
  end
end
