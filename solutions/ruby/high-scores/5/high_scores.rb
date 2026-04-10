class HighScores

  private

  attr_writer :scores,
              :latest,
              :personal_top_three,
              :personal_best,
              :latest_is_personal_best

  def initialize(scores)
    self.scores = scores
    self.latest = scores.last
    self.personal_top_three = scores.max(3)
    self.personal_best = personal_top_three.first
    self.latest_is_personal_best = (latest == personal_best)
  end

  public

  attr_reader :scores,
              :latest,
              :personal_top_three,
              :personal_best,
              :latest_is_personal_best

  alias_method :latest_is_personal_best?, :latest_is_personal_best

  undef_method :latest_is_personal_best

end

if $PROGRAM_NAME == __FILE__
  my_scores = HighScores.new([100, 0, 90, 30])

  puts "Scores: #{my_scores.scores}"
  puts "Latest score: #{my_scores.latest}"
  puts "Personal top three: #{my_scores.personal_top_three}"
  puts "Personal best: #{my_scores.personal_best}"
  puts "Is latest the personal best? #{my_scores.latest_is_personal_best?}"

  # (NoMethodError)
  # puts my_scores.latest_is_personal_best
end
