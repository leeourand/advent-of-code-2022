require 'ostruct'

class SupplyStacks
  def initialize(instructions, pick_multiple: false)
    @instructions = instructions
    @pick_multiple = pick_multiple
  end

  def top_of_stacks(options = {})
    stacks = extract_stacks_from_instructions
    moves = extract_moves_from_instructions
    result_stacks = apply_moves(stacks, moves)
    result_stacks.map(&:last).join("")
  end

  private

  def extract_stacks_from_instructions
    stack_strings = @instructions.scan(/\A[^\d]*/).first
      .chomp
      .split("\n")

    max_string_width = stack_strings.map(&:length).max

    stack_strings
      .map {|line| line.ljust(max_string_width).split("") }[0..-2]
      .transpose
      .map {|line| line.select {|c| c =~ /[A-Z]/}.reverse}
      .select {|a| a.length > 0}
  end

  def extract_moves_from_instructions
    @instructions.scan(/move (\d+) from (\d+) to (\d+)/).map do |count, from, to|
      OpenStruct.new(count: count.to_i, from: from.to_i, to: to.to_i)
    end
  end

  def apply_moves(stacks, moves)
    moves.reduce(stacks) do |updated_stacks, move|
      stack = updated_stacks[move.from - 1].pop(move.count)
      stack.reverse! unless @pick_multiple
      updated_stacks[move.to - 1].concat(stack)
      updated_stacks
    end
  end
end

if __FILE__ == $0
  input = File.read(File.join(__dir__, 'input.txt'))
  puts SupplyStacks.new(input).top_of_stacks
  puts SupplyStacks.new(input, pick_multiple: true).top_of_stacks
end
