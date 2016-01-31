module TicTacToe
  class Player
    attr_reader :id, :marker

    def initialize(id, marker)
      @marker = marker
      @id = id
    end

    def formatted
      "Player #{id} (#{marker})"
    end
  end
end
