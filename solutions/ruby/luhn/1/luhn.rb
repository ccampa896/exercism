Luhn = BasicObject.new

def Luhn.valid?(number)

  cleaned = number.delete(' ')

  return false if cleaned.length <= 1 || cleaned.match?(/\D/)

  checksum = cleaned.chars.reverse.each_with_index.sum do |char, index|

    digit = char.to_i

    if index.odd?
      double = digit * 2
      double > 9 ? double - 9 : double
    else
      digit
    end

  end

  checksum % 10 == 0
  
end
