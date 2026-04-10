class ResistorColorTrio

  TEMPLATE = 'Resistor value: %<value>i %<prefix>sohms'

  BAND = {
     'black' => 0,
     'brown' => 1,
       'red' => 2,
    'orange' => 3,
    'yellow' => 4,
     'green' => 5,
      'blue' => 6,
    'violet' => 7,
      'grey' => 8,
     'white' => 9
  }

  private

  attr_writer :colors

  def initialize(colors)
    self.colors = colors.take(3)
    base_value = (BAND[self.colors[0]] * 10) + BAND[self.colors[1]]
    multiplier = 10**BAND[self.colors[2]]
    @total_ohms = base_value * multiplier
  end

  public

  attr_reader :colors

  def label
    value = @total_ohms
    prefix = ''

    if value >= 1_000_000_000
      value /= 1_000_000_000
      prefix = 'giga'
    elsif value >= 1_000_000
      value /= 1_000_000
      prefix = 'mega'
    elsif value >= 1_000
      value /= 1_000
      prefix = 'kilo'
    end

    TEMPLATE % { value: value, prefix: prefix }
  end

end
