class Luhn
  CHECKSUM = ->(digit, index) do
    if index.odd?
      digit
    else
      double = digit * 2
      double > 9 ? double - 9 : double
    end
  end

  RE = REGULAR_EXPRESSION = {
    line_of_digits: /
      \A    # Start at beginning of line
      \d+   # match 1 or more digits
      \z    # up to the end of the line
    /x
  }

  private_constant :CHECKSUM, :RE

  def self.valid?(identifier)
    new(identifier).valid?
  end

  private

  attr_accessor :identifier, :checksum

  def initialize(identifier)
    self.identifier = identifier.to_s.delete(' ')
    self.checksum = valid_format? ? calculate_checksum : -1
  end

  def valid_format?
    identifier.length > 1 && identifier.match?(RE[:line_of_digits])
  end

  def calculate_checksum
    (1..identifier.length).sum do |i|
      CHECKSUM.call(identifier[-i].to_i, i)
    end
  end

  public

  def valid?
    (checksum % 10).zero?
  end

end

if $PROGRAM_NAME == __FILE__
  values = ['59', '0x3b', '073', '0b111011']

  values.each do |value|
    puts 'Testing %<value>p: %<result>p' %
      {value:, result: Luhn.valid?(Integer(value))}
  end
end
