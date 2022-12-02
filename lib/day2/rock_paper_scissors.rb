Round = Struct.new(:my_throw, :opponent_throw)

class StrategyGuide
  def initialize(guide)
    @guide = guide
  end

  def assumed_score
    assumed_translation = Proc.new do |oppo_throw, my_throw|
      map = { "A" => :rock, "B" => :paper, "C" => :scissors, "X" => :rock, "Y" => :paper, "Z" => :scissors }
      Round.new(map[my_throw], map[oppo_throw])
    end
    total_score(assumed_translation)
  end

  def informed_score
    informed_translation = Proc.new do |oppo_throw, condition|
      throw_map = { "A" => :rock, "B" => :paper, "C" => :scissors }
      condition_map = { "X" => :lose, "Y" => :draw, "Z" => :win }
      translated_oppo_throw = throw_map[oppo_throw]
      translated_condition = condition_map[condition]
      Round.new(throw_needed_for_condition(translated_oppo_throw, translated_condition), translated_oppo_throw)
    end
    total_score(informed_translation)
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

  def throw_needed_for_condition(opponent_throw, condition)
    case condition
    when :lose
      WINNER_LOSER_RELATIONSHIPS[opponent_throw]
    when :draw
      opponent_throw
    else
      (WINNER_LOSER_RELATIONSHIPS.keys - [opponent_throw] - [WINNER_LOSER_RELATIONSHIPS[opponent_throw]]).first
    end
  end

  def total_score(throw_translation)
    parse_guide(throw_translation).reduce(0) do |a, round|
      a + THROW_SCORES[round.my_throw] + score_for_result_of_round(round)
    end
  end

  def score_for_result_of_round(round)
    { lose: 0, draw: 3, win: 6 }[result_of_round(round)]
  end

  def result_of_round(round)
    return :win if WINNER_LOSER_RELATIONSHIPS[round.my_throw] == round.opponent_throw
    return :draw if round.my_throw == round.opponent_throw
    return :lose
  end

  def parse_guide(translation)
    guide.map(&translation)
  end
end

if __FILE__ == $0
  guide = File.read(File.join(__dir__, "inputs/input.txt")).split("\n").map {|line| line.chomp.split }
  puts "Assumed Score: #{StrategyGuide.new(guide).assumed_score}"
  puts "Informed Score: #{StrategyGuide.new(guide).informed_score}"
end
