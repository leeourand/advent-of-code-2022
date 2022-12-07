require 'minitest/autorun'
require_relative '../lib/day06/tuning_trouble'

class Day6Test < MiniTest::Test
  def test_finding_marker_position
    input = "bvwbjplbgvbhsrlpgdmjqwftvncz"
    result = TuningTrouble.new(input).start_of_packet_marker_position

    assert_equal 5, result

    input = "nppdvjthqldpwncqszvftbrmjlhg"
    result = TuningTrouble.new(input).start_of_packet_marker_position

    assert_equal 6, result

    input = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
    result = TuningTrouble.new(input).start_of_packet_marker_position

    assert_equal 10, result
  end
end
