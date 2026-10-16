require 'date'

module Year
  def self.leap?(year)
    Date.gregorian_leap?(year)
  end
end

if $PROGRAM_NAME == __FILE__
  puts Year.leap?(2015) # => false
  puts Year.leap?(1996) # => true
  puts Year.leap?(1900) # => false
  puts Year.leap?(2000) # => true
end
