FactoryGirl.define do
  factory :player, class: TicTacToe::Player do
    skip_create

    initialize_with{ TicTacToe::Player.new(0, '') }

    factory :player_one do
      initialize_with{ TicTacToe::Player.new(1, 'X') }
    end

    factory :player_two do
      initialize_with{ TicTacToe::Player.new(2, 'O') }
    end
  end
end
