class Luhn

  CHECKSUM = ->(digit, index) do
    if index.odd?
      digit
    else
      double = digit * 2
      double > 9 ? double - 9 : double
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
    self.checksum = valid_format? ? calculate_checksum : -1
  end

  def valid_format?
    number.length > 1 && number.match?(/\A\d+\z/)
  end

  def calculate_checksum
    (1..number.length).sum do |i|
      CHECKSUM.call(number[-i].to_i, i)
    end
  end

  public

  def valid?
    (checksum % 10).zero?
  end

end

if $PROGRAM_NAME == __FILE__
  values = [59, 0x3b, 073, 0b111011]

  values.each do |value|
    puts 'Testing %<value>p: %<result>p' % {value: value, result: Luhn.valid?(value)}
  end
end
