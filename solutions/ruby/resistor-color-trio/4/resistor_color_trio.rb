class ResistorColorTrio < Data.define(:colors)

  PREFIXES = ['', 'kilo', 'mega', 'giga']
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
  }
  private_constant :BAND

  def label
    tens, ones, multiplier = colors.take(3).map { |color| BAND[color.to_sym] }

    base = tens * 10 + ones
    zeros = multiplier

    if base > 0 && base % 10 == 0
      base /= 10
      zeros += 1
    end

    prefix_index = zeros / 3
    remaining_zeros = zeros % 3

    final_value = base * 10**remaining_zeros
    prefix = PREFIXES[prefix_index]

    "Resistor value: #{final_value} #{prefix}ohms"
  end

  alias to_s label
end

if $PROGRAM_NAME == __FILE__
  resistor1 = ResistorColorTrio.new(["yellow", "violet", "yellow"])

  resistor2 = ResistorColorTrio.new(["red", "black", "green"])

  puts resistor1
  puts resistor2
end
