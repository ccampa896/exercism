class Scrabble

  SCORE_CHART = {
    'AEIOULNRST' => 1,
    'DG'         => 2,
    'BCMP'       => 3,
    'FHVWY'      => 4,
    'K'          => 5,
    'JX'         => 8,
    'QZ'         => 10
  }

  def initialize(word)
    @word = word.to_s.upcase
  end

  def score
    SCORE_CHART.sum do |letters, value|
      @word.count(letters) * value
    end
  end

end
