class RopeBridge
  def initialize input, length=2
    @moves = input.split("\n").map {|move| parse_move(move) }
    @segments = length.times.map { Point.new(0, 0) }
  end

  def count_positions_tail_visited
    @moves.reduce({}) do |locations, move|
      move[:distance].times do
        head = @segments.first
        head.move(move[:direction])
        @segments[1..-1].each_with_index {|segment, idx| segment.move_toward(@segments[idx]) }
        tail = @segments.last
        locations[tail.x] ||= {}
        locations[tail.x][tail.y] = true
      end
      locations
    end
      .reduce(0) {|a, (k, v)| a + v.select {|p| p }.count}
  end

  private

  def parse_move(move)
    direction = case move[0]
                when "R"
                  :right
                when "L"
                  :left
                when "U"
                  :up
                when "D"
                  :down
                end
    distance = Integer(move[2..-1])
    { direction: direction, distance: distance }
  end
end

class Point < Struct.new(:x, :y)
  def move(direction)
    case direction
    when :right
      self.x = self.x + 1
    when :left
      self.x = self.x - 1
    when :up
      self.y = self.y + 1
    when :down
      self.y = self.y - 1
    end
  end

  def move_toward(point)
    diff_x = point.x - self.x
    diff_y = point.y - self.y
    if diff_x.abs > 1
      self.x = Integer(self.x + (diff_x  * 1.0/diff_x.abs))
      if diff_y.abs > 0
        self.y = Integer(self.y + (diff_y  * 1.0/diff_y.abs))
      else
      end
    elsif diff_y.abs > 1
      self.y = Integer(self.y + (diff_y  * 1.0/diff_y.abs))
      if diff_x.abs > 0
        self.x = Integer(self.x + (diff_x  * 1.0/diff_x.abs))
      else
      end
    end
  end
end

if __FILE__ == $0
  input = File.read(File.join(__dir__, 'input.txt'))
  puts RopeBridge.new(input).count_positions_tail_visited
  puts RopeBridge.new(input, 10).count_positions_tail_visited
end
