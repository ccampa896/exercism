require 'date'

module Year
  def self.leap?(year)
    year.gregorian_leap?
  end
end
