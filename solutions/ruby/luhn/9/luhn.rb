class Luhn

  CHECKSUM = ->(digit, index) do
    if index.even?
      double = digit * 2
      double > 9 ? double - 9 : double
    else
      digit
    end
  end
  private_constant :CHECKSUM

  def self.valid?(number)
    new(number).valid?
  end

  private

  attr_accessor :number, :checksum

  def initialize(number)
    self.number = number.to_s.delete(' ')
    self.checksum = valid_format? ? calculate_checksum : nil
  end

  def valid_format?
    number.length > 1 && number.match?(/\A\d+\z/)
  end

  def calculate_checksum
    (1..number.length).sum do |i|
      digit = number[-i].to_i
      CHECKSUM.call(digit, i)
    end
  end

  public

  def valid?
    checksum and checksum % 10 == 0
  end

end

if $PROGRAM_NAME == __FILE__
  puts "Testing 59 (Decimal): #{Luhn.valid?(59)}"
  puts "Testing 0x3b (Hexadecimal): #{Luhn.valid?(0x3b)}"
  puts "Testing 073 (Octal): #{Luhn.valid?(073)}"
  puts "Testing 0b111011 (Binary): #{Luhn.valid?(0b111011)}"
end
