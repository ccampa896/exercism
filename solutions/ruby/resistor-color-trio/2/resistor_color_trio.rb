class ResistorColorTrio

  TEMPLATE = 'Resistor value: %<value>i %<prefix>sohms'
  private_constant :TEMPLATE

  BAND = {
    black: 0,
    brown: 1,
      red: 2,
   orange: 3,
   yellow: 4,
    green: 5,
     blue: 6,
   violet: 7,
     grey: 8,
    white: 9
  }
  private_constant :BAND

  private

  attr_writer :bands, :resistance

  def initialize(colors)
    self.bands = colors.take(3).map(&:to_sym)

    base_value = (BAND[bands[0]] * 10) + BAND[bands[1]]
    multiplier = 10**BAND[bands[2]]

    self.resistance = base_value * multiplier
  end

  attr_reader :resistance

  public

  attr_reader :bands

  def label
    value = resistance

    divisor, prefix = if value >= 1_000_000_000
                        [1_000_000_000, 'giga']
                      elsif value >= 1_000_000
                        [1_000_000, 'mega']
                      elsif value >= 1_000
                        [1_000, 'kilo']
                      else
                        [1, '']
                      end

    value /= divisor

    TEMPLATE % {value: value, prefix: prefix}
  end

  alias to_s label

end

if $PROGRAM_NAME == __FILE__
  resistor = ResistorColorTrio.new(["orange", "orange", "black"])

  puts resistor.label

  puts "#{resistor}"
end
