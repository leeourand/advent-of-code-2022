Round = Struct.new(:my_throw, :opponent_throw)

class StrategyGuide
  def initialize(guide)
    @guide = guide
  end

  def total_score
    parse_guide.reduce(0) do |a, round|
      a + THROW_SCORES[round.my_throw] + score_for_result_of_round(round)
    end
  end

  private

  attr_reader :guide

  THROW_SCORES = {
    rock: 1,
    paper: 2,
    scissors: 3,
  }

  WINNER_LOSER_RELATIONSHIPS = {
    rock: :scissors,
    paper: :rock,
    scissors: :paper
  }

  def score_for_result_of_round(round)
    { lose: 0, draw: 3, win: 6 }[result_of_round(round)]
  end

  def result_of_round(round)
    return :win if WINNER_LOSER_RELATIONSHIPS[round.my_throw] == round.opponent_throw
    return :draw if round.my_throw == round.opponent_throw
    return :lose
  end

  def parse_guide
    translation = { "A" => :rock, "B" => :paper, "C" => :scissors, "X" => :rock, "Y" => :paper, "Z" => :scissors }
    guide.map do |round|
      Round.new(translation[round[1]], translation[round[0]])
    end
  end
end

if __FILE__ == $0
  guide = File.read(File.join(__dir__, "inputs/input.txt")).split("\n").map {|line| line.chomp.split }
  puts StrategyGuide.new(guide).total_score
end
