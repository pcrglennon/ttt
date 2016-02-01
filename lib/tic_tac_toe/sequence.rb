module TicTacToe
  class Sequence
    attr_reader :values, :size

    def initialize(values)
      @values = values
      @size = values.size
    end

    # Returns true if values are identical (non-nil) markers
    def complete?
      values == values.compact && values.uniq.count == 1
    end

    def count(character)
      values.count(character)
    end

    def index_of(character)
      values.find_index { |v| v == character }
    end
  end
end
