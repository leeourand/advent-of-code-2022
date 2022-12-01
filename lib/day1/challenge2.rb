require_relative 'calorie_counting'

elves = BuildsElves.build(File.read(File.join(__dir__, "inputs/input1.txt")))
puts CalorieCounter.new(elves).elves_with_most_calories(3).sum(&:total_calories)
