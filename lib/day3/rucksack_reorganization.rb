class RucksackReorganization
  def initialize(rucksack_contents)
    @rucksack_contents = parse(rucksack_contents)
  end

  def sum_of_misorganized_item_priorities
    priorities_for_items(misorganized_items).sum
  end

  def sum_of_badge_priorities
    priorities_for_items(find_group_badges).sum
  end

  private

  attr_reader :rucksack_contents

  def find_group_badges
    rucksack_contents.each_slice(3).map do |group|
      group[0].intersection(group[1]).intersection(group[2])
    end.flatten
  end

  def misorganized_items
    rucksack_contents
      .map { |rucksack| rucksack.each_slice(rucksack.size / 2.0).to_a }
      .map do |rucksack|
      rucksack.first.intersection(rucksack.last)
    end.flatten
  end

  def priorities_for_items(items)
    items.map do |item|
      value_for(item)
    end
  end

  def value_for(item)
    (('a'..'z').to_a + ('A'..'Z').to_a).index(item) + 1
  end

  def parse(contents)
    contents
      .split("\n")
      .map { |rucksack| rucksack.split('') }
  end
end

if __FILE__ == $0
  input = File.read(File.join(__dir__, 'inputs/input.txt'))
  puts RucksackReorganization.new(input).sum_of_misorganized_item_priorities
  puts RucksackReorganization.new(input).sum_of_badge_priorities
end
