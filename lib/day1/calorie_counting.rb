class CalorieCounter
  def initialize(elves)
    @elves = elves
  end

  def elf_with_most_calories
    elves_sorted_by_calories.last
  end

  def elves_with_most_calories(n)
    elves_sorted_by_calories.last(n)
  end

  private

  def elves_sorted_by_calories
    @elves.sort_by(&:total_calories)
  end
end

class Elf
  attr_reader :item_calories
  def initialize(item_calories)
    @item_calories = item_calories
  end

  def total_calories
    @item_calories.sum
  end

  def ==(other)
    item_calories == other.item_calories
  end
end

class BuildsElves
  def self.build(input)
    input.split("\n\n").map do |elf_inputs|
      calories = elf_inputs.split("\n").map(&:to_i)
      Elf.new(calories)
    end
  end
end
