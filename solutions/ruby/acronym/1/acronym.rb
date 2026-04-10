module Acronym
  def self.abbreviate(str)
    str
      .gsub('-', ' ')
      .gsub(/[^a-zA-Z\s]/, '') 
      .split                   
      .map { |word| word[0].upcase }
      .join
  end
end