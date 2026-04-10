module Acronym

  RE = REGULAR_EXPRESSIONS = {
    word: /
      [A-Za-z'] # Match letter and apostrophe
      +         # One or more times
      (?<!')    # Negative lookbehind to ensure it doesn't end with an apostrophe
    /x,
  }

  private_constant :RE

  def self.abbreviate(phrase)
    phrase
      .scan(RE[:word])
      .map { |word| word[0].upcase }
      .join
  end

end
