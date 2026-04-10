class HighScores

  private

  attr_writer :scores,
              :latest,
              :personal_top_three,
              :personal_best,
              :latest_is_personal_best

  def initialize(*scores)
    self.scores = scores.flatten
    self.latest = self.scores.last
    self.personal_top_three = self.scores.max(3)
    self.personal_best = personal_top_three.first
    self.latest_is_personal_best = latest == personal_best
  end

  public

  attr_reader :scores,
              :latest,
              :personal_top_three,
              :personal_best,
              :latest_is_personal_best

  alias latest_is_personal_best? latest_is_personal_best
  undef latest_is_personal_best

end

if $PROGRAM_NAME == __FILE__
  my_scores1 = HighScores.new(100, 0, 90, 30)
  my_scores2 = HighScores.new([100, 0, 90, 30])

  puts "Scores 1 (Args): #{my_scores1.scores}"
  puts "Scores 2 (Array): #{my_scores2.scores}"

  puts "Latest score 1: #{my_scores1.latest}"
  puts "Latest score 2: #{my_scores2.latest}"

  puts "Personal top three 1: #{my_scores1.personal_top_three}"
  puts "Personal top three 2: #{my_scores2.personal_top_three}"

  puts "Personal best 1: #{my_scores1.personal_best}"
  puts "Personal best 2: #{my_scores2.personal_best}"

  puts "Is latest (1) the personal best? #{my_scores1.latest_is_personal_best?}"
  puts "Is latest (2) the personal best? #{my_scores2.latest_is_personal_best?}"
end
