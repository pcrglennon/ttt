FactoryGirl.define do
  factory :computer_player, class: TicTacToe::ComputerPlayer do
    skip_create

    initialize_with{ TicTacToe::ComputerPlayer.new(2, 'O', 'X') }
  end
end
