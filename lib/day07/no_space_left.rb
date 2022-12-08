class NoSpaceLeft
  def initialize(terminal_text)
    @terminal_text = terminal_text
  end

  def sum_largest_directories_size
    directory_sizes.select do |k,v|
      v < 100_000
    end.sum(&:last)
  end

  def optimal_directory_for_deletion
    unused_disk_space = 70000000 - directory_sizes[["/"]]
    space_needed = 30000000 - unused_disk_space
    directory_sizes.select {|_, v| v > space_needed}.min_by(&:last).last
  end

  def directory_sizes
    lines = @terminal_text.split("\n")
    sizes = {}
    current_directory = []
    lines.each_with_index do |line, index|
      if dir = line.scan(/^\$ cd (.*)/)&.first&.first
        if dir == ".."
          current_directory.pop
        else
          current_directory.push(dir)
          sizes[current_directory.dup] = sum_counts_in_directory(lines[index..-1])
        end
      end
    end
    sizes
  end

  def sum_counts_in_directory(lines)
    descends = -1
    relevant_lines = lines.take_while do |line|
      if line.match?(/^\$ cd [^\.]/)
        descends += 1
      end
      if line.match?(/^\$ cd \.\./)
        descends -= 1
      end
      descends >= 0
    end
    relevant_lines.map do |line|
      line.scan(/^(\d+) .*/)&.first&.first
    end
    .compact.map(&:to_i).sum
  end
end

if __FILE__ == $0
  input = File.read(File.join(__dir__, 'input.txt'))
  puts NoSpaceLeft.new(input).sum_largest_directories_size
  puts NoSpaceLeft.new(input).optimal_directory_for_deletion
end
