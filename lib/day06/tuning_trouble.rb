class TuningTrouble
  def initialize(signal, marker_length: 4)
    @signal = signal
    @marker_length = marker_length
  end

  def start_of_packet_marker_position
    @signal.split("").each_cons(@marker_length).find_index do |packet|
      packet.uniq == packet
    end + @marker_length
  end
end

if __FILE__ == $0
  input = File.read(File.join(__dir__, 'input.txt'))
  puts TuningTrouble.new(input).start_of_packet_marker_position
  puts TuningTrouble.new(input, marker_length: 14).start_of_packet_marker_position
end
