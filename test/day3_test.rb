require 'minitest/autorun'
require_relative '../lib/day3/rucksack_reorganization'

class Day3Test < MiniTest::Test
  def test_reorganizing_rucksacks
    input = <<~EOF
    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw
    EOF

    result = RucksackReorganization.new(input).sum_of_misorganized_item_priorities

    assert_equal 157, result
  end

  def test_finding_group_badges
    input = <<~EOF
    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw
    EOF

    result = RucksackReorganization.new(input).sum_of_badge_priorities

    assert_equal 70, result
  end
end
