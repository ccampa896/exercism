
module Year
  def self.leap?(year)
    (year % 4).zero? &&
      (!(year % 100).zero? || (year % 400).zero?)
  end
end

puts Year.leap?(2015) # false
puts Year.leap?(1996) # true
puts Year.leap?(1900) # false
puts Year.leap?(2000) # true
