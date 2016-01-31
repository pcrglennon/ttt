FactoryGirl.define do
  factory :player, class: TicTacToe::Player do
    skip_create

    initialize_with{ TicTacToe::Player.new('') }

    factory :player_one do
      initialize_with{ TicTacToe::Player.new('X') }
    end

    factory :player_two do
      initialize_with{ TicTacToe::Player.new('O') }
    end
  end
end
