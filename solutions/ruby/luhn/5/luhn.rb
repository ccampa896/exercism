class Luhn

  CHECKSUM = ->(digit, index) do
    if index.even?
      digit
    else
      double = digit * 2
      double > 9 ? double - 9 : double
    end
  end
  private_constant :CHECKSUM

  def self.valid?(number, &block)
    checksum_calculator = block_given? ? block : CHECKSUM
    new(number, checksum_calculator).valid?
  end

  private

  attr_accessor :input, :checksum, :calculator

  def initialize(number, calculator)
    self.input = number.to_s.delete(' ')
    self.calculator = calculator
    self.checksum = valid_format? ? digits_with_index.sum : -1
  end

  def valid_format?
    input.length > 1 && !input.match?(/\D/)
  end

  def digits_with_index
    input.chars.reverse.map(&:to_i).each_with_index.map(&calculator)
  end

  public

  def valid?
    checksum % 10 == 0
  end

end

if $PROGRAM_NAME == __FILE__
  puts "Testing 59 (Decimal): #{Luhn.valid?(59)}"
  puts "Testing 0x3b (Hexadecimal): #{Luhn.valid?(0x3b)}"
  puts "Testing 073 (Octal): #{Luhn.valid?(073)}"
  puts "Testing 0b111011 (Binary): #{Luhn.valid?(0b111011)}"
end
