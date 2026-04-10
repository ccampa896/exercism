class Luhn

  LUHN_CHECKSUM = ->(digit, index) do
    if index.even?
      digit
    else
      double = digit * 2
      double > 9 ? double - 9 : double
    end
  end
  private_constant :LUHN_CHECKSUM

  def self.valid?(number)
    new(number).valid?
  end

  private

  attr_accessor :input, :calculated_checksum

  def initialize(number)
    # step 1: clean
    self.input = number.to_s.delete(' ')

    if valid_format?
      self.calculated_checksum = digits_with_index.sum
    else
      self.calculated_checksum = -1
    end
  end

  # step 2: logic extracted into a semantic method
  def valid_format?
    input.length > 1 && !input.match?(/\D/)
  end

  # step 3: normalize
  def digits_with_index
    input.chars.reverse.map(&:to_i).each_with_index.map(&LUHN_CHECKSUM)
  end

  public

  # step 5: the orchestrator
  def valid?
    calculated_checksum % 10 == 0
  end

end

if $PROGRAM_NAME == __FILE__
  puts "Testing 59 (Decimal): #{Luhn.valid?(59)}"
  puts "Testing 0x3b (Hexadecimal): #{Luhn.valid?(0x3b)}"
  puts "Testing 073 (Octal): #{Luhn.valid?(073)}"
  puts "Testing 0b111011 (Binary): #{Luhn.valid?(0b111011)}"
end
