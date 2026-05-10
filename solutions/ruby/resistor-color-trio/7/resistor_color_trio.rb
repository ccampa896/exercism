module ResistorDecoding

  begin
    PREFIXES = ['', 'kilo', 'mega', 'giga']

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

    SIGNIFICANT_BANDS = 3
    BASE = 10
    ZEROS_PER_PREFIX = 3
    DEFAULT_TEMPLATE = 'Resistor value: %<value>i %<prefix>sohms'

    private_constant :PREFIXES, :BAND, :SIGNIFICANT_BANDS, 
                     :BASE, :ZEROS_PER_PREFIX, :DEFAULT_TEMPLATE
  end

  def label(template: DEFAULT_TEMPLATE)
    template % { value: final_value, prefix: prefix }
  end

  private

  def numeric_values
    colors.take(SIGNIFICANT_BANDS).map { |color| BAND[color.to_sym] }
  end

  def base_with_zeros
    tens, ones, multiplier = numeric_values
    base = tens * BASE + ones
    zeros = multiplier

    decimal?(base) and {base: base / BASE, zeros: zeros.next} or {base: base, zeros: zeros}
  end

  def decimal?(base)
    base > 0 && (base % BASE).zero?
  end

  def final_value
    data = base_with_zeros
    data[:base] * (BASE**(data[:zeros] % ZEROS_PER_PREFIX))
  end

  def prefix
    data = base_with_zeros
    PREFIXES[data[:zeros] / ZEROS_PER_PREFIX]
  end
end

ResistorColorTrio = Data.define(:colors) do
  include ResistorDecoding

  alias to_s label
end

if $PROGRAM_NAME == __FILE__
  resistor1 = ResistorColorTrio.new(["yellow", "violet", "yellow"])
  resistor2 = ResistorColorTrio.new(["red", "black", "green"])

  puts resistor1
  puts resistor2

  puts resistor1.label(template: "Valor: %<value>i %<prefix>sohms")
end
