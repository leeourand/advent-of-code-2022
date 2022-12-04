require 'minitest/autorun'
require_relative '../lib/day02/rock_paper_scissors'

class Day2Test < MiniTest::Test
  def test_building_elves_from_assumed_string
    guide = [["B", "Y"], ["C", "X"], ["A", "Z"], ["B", "X"]]
    total_score = StrategyGuide.new(guide).assumed_score
    assert_equal (5 + 7 + 3 + 1), total_score
  end

  def test_building_elves_from_informed_string
    guide = [["A", "Y"], ["B", "X"], ["C", "Z"]]
    total_score = StrategyGuide.new(guide).informed_score
    assert_equal 12, total_score
  end
end
