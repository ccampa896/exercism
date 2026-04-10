class HighScores

  private

  attr_writer :scores

  def initialize(scores)
    self.scores = scores
    @latest = scores.last
    @personal_top_three = scores.max(3)
    @personal_best = @personal_top_three.first
    @latest_is_personal_best = (@latest == @personal_best)
  end

  public

  attr_reader :scores, :latest, :personal_best, :personal_top_three

  def latest_is_personal_best?
    @latest_is_personal_best
  end

end

if $PROGRAM_NAME == __FILE__
  my_scores = HighScores.new([100, 0, 90, 30])
  
  puts "Scores: #{my_scores.scores}"
  puts "Latest score: #{my_scores.latest}"
  puts "Personal top three: #{my_scores.personal_top_three}"
  puts "Personal best: #{my_scores.personal_best}"
  puts "Is latest the personal best? #{my_scores.latest_is_personal_best?}"
end
