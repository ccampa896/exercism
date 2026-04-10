module Acronym
  REGULAR_EXPRESSIONS = {
    word: /
      [A-Za-z'] # Match letter and apostrophe
      +         # One or more times
      (?<!')    # Negative lookbehind to ensure it doesn't end with an apostrophe
    /x
  }.freeze

  def self.abbreviate(phrase)

    phrase
      .scan(REGULAR_EXPRESSIONS[:word])
      .map { |word| word[0].upcase }
      .join

  end
end