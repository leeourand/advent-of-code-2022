require 'minitest/autorun'
require_relative '../lib/day09/rope_bridge'

class Day9Test < MiniTest::Test
  def test_tail_visits
    input = <<~EOF
    R 4
    U 4
    L 3
    D 1
    R 4
    D 1
    L 5
    R 2
    EOF

    result = RopeBridge.new(input).count_positions_tail_visited

    assert_equal 13, result
  end

  def test_other_inputs
    input = <<~EOF
    R 5
    U 8
    L 8
    D 3
    R 17
    D 10
    L 25
    U 20
    EOF

    result = RopeBridge.new(input, 10).count_positions_tail_visited

    assert_equal 36, result
  end

  def test_move_toward
    point1 = Point.new(2, 1)
    point2 = Point.new(1, 3)

    point2.move_toward(point1)

    assert_equal Point.new(2, 2), point2
  end
end
