require 'pry'

class TreeHouse
  def initialize(input)
    @trees = input
      .split("\n")
      .map {|row| row.split("").map(&:to_i) }
  end

  def visible_trees_count
    @trees.map.with_index do |row, i|
      row.map.with_index do |tree, j|
        tree_visible?(tree, i, j)
      end
    end
      .flatten
      .select {|t| t }
      .count
  end

  def highest_scenic_score
    @trees.map.with_index do |row, i|
      row.map.with_index do |tree, j|
        scenic_score?(tree, i, j)
      end
    end
      .flatten
      .max
  end

  private

  def tree_visible?(tree, i, j)
    @trees[i][0...j].all? {|t| t < tree} ||
      @trees[i][j+1..-1].all? {|t| t < tree} ||
      @trees.transpose[j][0...i].all? {|t| t < tree } ||
      @trees.transpose[j][i+1..-1].all? {|t| t < tree }
  end

  def scenic_score?(tree, i, j)
    left = @trees[i][0...j].reverse.take_while {|t| t < tree}.count
    left += 1 if j - left > 0
    right = @trees[i][j+1..-1].take_while {|t| t < tree}.count
    right += 1 if j + right < @trees.length - 1
    up = @trees.transpose[j][0...i].reverse.take_while {|t| t < tree}.count
    up += 1 if i - up > 0
    down = @trees.transpose[j][i+1..-1].take_while {|t| t < tree}.count
    down += 1 if i + down < @trees.length - 1

    left * right * up * down
  end
end

if __FILE__ == $0
  input = File.read(File.join(__dir__, 'input.txt'))
  puts TreeHouse.new(input).visible_trees_count
  puts TreeHouse.new(input).highest_scenic_score
end
