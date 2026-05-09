module ResistorDecoding
  PREFIXES = ['', 'kilo', 'mega', 'giga'].freeze
  private_constant :PREFIXES

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
  }.freeze
  private_constant :BAND

  def label
    "Resistor value: #{final_value} #{prefix}ohms"
  end

  private

  def numeric_values
    colors.take(3).map { |color| BAND[color.to_sym] }
  end

  def adjusted_base_and_zeros
    tens, ones, multiplier = numeric_values
    base = (tens * 10) + ones
    zeros = multiplier

    if base > 0 && base % 10 == 0
      [base / 10, zeros + 1]
    else
      [base, zeros]
    end
  end

  def final_value
    base, zeros = adjusted_base_and_zeros
    remaining_zeros = zeros % 3
    base * (10**remaining_zeros)
  end

  def prefix
    _, zeros = adjusted_base_and_zeros
    PREFIXES[zeros / 3]
  end
end

ResistorColorTrio = Data.define(:colors) do
  include ResistorDecoding
  
  alias to_s label
end

if $PROGRAM_NAME == __FILE__
  resistor1 = ResistorColorTrio.new(["yellow", "violet", "yellow"])
  resistor2 = ResistorColorTrio.new(["red", "black", "green"])

  puts resistor1 # => Resistor value: 470 kiloohms
  puts resistor2 # => Resistor value: 2 megaohms
end
