class HighScores
  attr_reader :scores
  
  def initialize(scores)
    self.scores = scores
  end

  def list_of_scores
    scores
  end

  def latest
    scores.last
  end

  def personal_best
    scores.max
  end

  def latest_is_personal_best?
    self.latest == self.personal_best
  end

  def personal_top_three
    scores.sort_by { |n| -n }[0..2]
  end

  private

  attr_writer :scores
end