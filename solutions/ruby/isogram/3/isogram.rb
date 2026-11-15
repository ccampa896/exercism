module Isogram

  def isogram?(phrase)
    letters = phrase.downcase.scan(/[[:alpha:]]/)
    letters.uniq.length == letters.length
  end

end

Isogram.extend(Isogram)
