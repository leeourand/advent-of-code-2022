require 'minitest/autorun'
require_relative '../lib/day08/tree_house'

class Day8Test < MiniTest::Test
  def test_finding_visible_trees
    input = <<~EOF
		30373
		25512
		65332
		33549
		35390
    EOF

    result = TreeHouse.new(input).visible_trees_count

    assert_equal 21, result
  end

  def test_highest_scenic_score
    input = <<~EOF
		30373
		25512
		65332
		33549
		35390
    EOF

    result = TreeHouse.new(input).highest_scenic_score

    assert_equal 8, result
  end
end
