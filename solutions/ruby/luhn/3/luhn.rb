class Luhn

  def self.valid?(number)
    new(number).valid?
  end

  private

  attr_writer :input

  def initialize(number)
    self.input = number.to_s.delete(' ')
  end

  public

  attr_reader :input

  # step 5: the orchestrator 
  def valid?
    # step 2: validate
    return false unless valid_format?

    # step 4 & 5: calculate and check remainder
    checksum % 10 == 0
  end

  private

  # step 2 logic extracted into a semantic method
  def valid_format?
    input.length > 1 && !input.match?(/\D/)
  end

  # step 3: normalize
  def digits_with_index
    input.chars.reverse.map(&:to_i).each_with_index
  end

  # step 4: business logic
  def checksum
    digits_with_index.sum do |digit, index|
      if index.even?
        digit
      else
        double = digit * 2
        double > 9 ? double - 9 : double
      end
    end
  end

end

# Our "Library Guard" for testing
if $PROGRAM_NAME == __FILE__
  puts "Testing 59 (Decimal): #{Luhn.valid?(59)}"
  puts "Testing 0x3b (Hexadecimal): #{Luhn.valid?(0x3b)}"
  puts "Testing 073 (Octal): #{Luhn.valid?(073)}"
  puts "Testing 0b111011 (Binary): #{Luhn.valid?(0b111011)}"
end
