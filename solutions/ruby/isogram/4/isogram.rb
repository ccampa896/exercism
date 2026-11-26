module Isogram

  def isogram?(phrase)
    seen = Set.new

    phrase.downcase.scan(/[[:alpha:]]/) do |letter|
      return false unless seen.add?(letter)
    end

    true
  end

end

Isogram.extend(Isogram)
