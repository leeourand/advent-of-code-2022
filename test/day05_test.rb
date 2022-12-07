require 'minitest/autorun'
require_relative '../lib/day05/supply_stacks'

class Day5Test < MiniTest::Test
  def test_rearranging_stacks
    input = <<~EOF
        [D]
    [N] [C]
    [Z] [M] [P]
		 1   2   3

		move 1 from 2 to 1
		move 3 from 1 to 3
		move 2 from 2 to 1
		move 1 from 1 to 2
    EOF

    result = SupplyStacks.new(input).top_of_stacks

    assert_equal "CMZ", result
  end
end
