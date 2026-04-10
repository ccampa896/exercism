Luhn = BasicObject.new

def Luhn.valid?(number)

  # clean spaces and protect against Integer inputs of different bases (to_s)
  cleaned = number.to_s.delete(' ')

  # validate while it is still a String
  return false if cleaned.length <= 1 || cleaned.match?(/\D/)

  # normalization
  digits = cleaned.chars.reverse.map(&:to_i)

  # business logic
  checksum = digits.each_with_index.sum do |digit, index|
    # the simplest case comes first
    if index.even?
      digit
    else
      double = digit * 2
      double > 9 ? double - 9 : double
    end
  end

  # the verdict
  checksum % 10 == 0

end

if $PROGRAM_NAME == __FILE__
  puts "Testing 59 (Decimal): #{Luhn.valid?(59)}"
  puts "Testing 0x3b (Hexadecimal): #{Luhn.valid?(0x3b)}"
  puts "Testing 073 (Octal): #{Luhn.valid?(073)}"
  puts "Testing 0b111011 (Binary): #{Luhn.valid?(0b111011)}"
end
