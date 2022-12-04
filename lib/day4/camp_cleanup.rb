class CampCleanup
  def initialize(input)
    @assignments = input
      .split("\n")
      .map do |pair|
        pair
          .split(",")
          .map {|range| Assignment.new(*(range.split("-"))) }
      end
  end

  def count_fully_contained_overlaps
    assignments.reduce(0) do |sum, pair|
      sum + (pair.first.fully_contained?(pair.last) ? 1 : 0)
    end
  end

  def count_overlaps
    assignments.reduce(0) do |sum, pair|
      sum + (pair.first.overlap?(pair.last) ? 1 : 0)
    end
  end

  private

  attr_reader :assignments
end

class Assignment
  attr_reader :range
  def initialize(starts_at, ends_at)
    @range = (starts_at..ends_at).to_a
  end

  def overlap?(other)
    range.intersection(other.range).length > 0
  end

  def fully_contained?(other)
    intersection = range.intersection(other.range)
    intersection == other.range || intersection == range
  end
end

if __FILE__ == $0
  input = File.read(File.join(__dir__, 'input.txt'))
  puts CampCleanup.new(input).count_fully_contained_overlaps
  puts CampCleanup.new(input).count_overlaps
end
