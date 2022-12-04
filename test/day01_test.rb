require 'minitest/autorun'
require_relative '../lib/day01/calorie_counting'

class Day1Test < MiniTest::Test
  def test_finding_elf_with_most_calories
    elf_with_some_calories = Elf.new([10, 20])
    elf_with_most_calories = Elf.new([20, 30])
    elves = [elf_with_some_calories, elf_with_most_calories]

    assert_equal CalorieCounter.new(elves).elf_with_most_calories, elf_with_most_calories
  end

  def test_finding_elves_with_most_calories
    elf_with_least_calories = Elf.new([9])
    elf_with_some_calories = Elf.new([10, 20])
    elf_with_most_calories = Elf.new([20, 30])
    elves = [elf_with_least_calories, elf_with_some_calories, elf_with_most_calories]

    assert_equal CalorieCounter.new(elves).elves_with_most_calories(2), [elf_with_some_calories, elf_with_most_calories]
  end

  def test_building_elves_from_string
    input = <<~CALORIES
    10
    20
    30

    4
    5
    6
    CALORIES
    result = BuildsElves.build(input)
    assert_equal result, [Elf.new([10, 20, 30]), Elf.new([4, 5, 6])]
  end
end
