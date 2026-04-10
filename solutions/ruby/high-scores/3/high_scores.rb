class HighScores

  def initialize(scores)
    @scores = scores
  end

  public

  attr_reader :scores

  def latest
    @latest ||= scores.last
  end

  def personal_top_three
    @personal_top_three ||= scores.max(3)
  end

  def personal_best
    personal_top_three.first
  end

  def latest_is_personal_best?
    latest == personal_best
  end

end
