require 'minitest/autorun'
require_relative '../lib/day04/camp_cleanup'

class Day4Test < MiniTest::Test
  def test_finding_fully_contained_overlaps
    input = <<~EOF
    2-4,6-8
    2-3,4-5
    5-7,7-9
    2-8,3-7
    6-6,4-6
    2-6,4-8
    EOF

    result = CampCleanup.new(input).count_fully_contained_overlaps

    assert_equal 2, result
  end

  def test_finding_overlaps
    input = <<~EOF
    2-4,6-8
    2-3,4-5
    5-7,7-9
    2-8,3-7
    6-6,4-6
    2-6,4-8
    EOF

    result = CampCleanup.new(input).count_overlaps

    assert_equal 4, result
  end
end
