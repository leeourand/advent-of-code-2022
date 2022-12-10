class CathodeRayTube
  def initialize(input, relevant_cycles=[])
    @instructions = input.split("\n")
    @relevant_cycles = relevant_cycles
  end

  def signal_strengths
    register_x_cycle_values.map.with_index do |c, idx|
      if @relevant_cycles.include?(idx+1)
        (idx+1) * c
      end
    end
      .compact
  end

  def message(display_width=40)
    register_x_cycle_values.map.with_index do |sprite_position, index|
      ((sprite_position - 1)..(sprite_position + 1)).cover?(index % display_width)
    end
      .each_slice(display_width).map do |slice|
        slice.map do |c|
          if c
            "#"
          else
            "."
          end
        end.join("")
      end
  end

  private

  def register_x_cycle_values
    register_x = 1
    @instructions.reduce([]) do |state, instruction|
      case instruction
      when /^noop/
        state.push(register_x)
      when /^addx (-?\d+)/
        state.push(register_x)
        state.push(register_x)
        register_x += Integer($1)
      end
      state
    end
  end
end

if __FILE__ == $0
  input = File.read(File.join(__dir__, 'input.txt'))
  puts CathodeRayTube.new(input, [20, 60, 100, 140, 180, 220]).signal_strengths.sum
  puts CathodeRayTube.new(input).message
end
