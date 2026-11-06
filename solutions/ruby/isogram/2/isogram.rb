module Isogram

  def self.isogram?(phrase)
    letters = phrase.downcase.scan(/[[:alpha:]]/)
    letters.uniq.size == letters.size
  end

end
