module ResistorDecoding

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

  SIGNIFICANT_BANDS = 3
  private_constant :SIGNIFICANT_BANDS

  DECIMAL_BASE = 10
  private_constant :DECIMAL_BASE

  ZEROS_PER_PREFIX = 3
  private_constant :ZEROS_PER_PREFIX

  DEFAULT_TEMPLATE = 'Resistor value: %<value>i %<prefix>sohms'
  private_constant :DEFAULT_TEMPLATE

  def label(template: DEFAULT_TEMPLATE)
    template % { value: final_value, prefix: prefix }
  end

  private

  def numeric_values
    colors.take(SIGNIFICANT_BANDS).map{|color| BAND[color.to_sym]}
  end

  def base_with_zeros
    tens, ones, multiplier = numeric_values
    base = tens * DECIMAL_BASE + ones
    zeros = multiplier

    if base > 0 && (base % DECIMAL_BASE).zero?
      [base / DECIMAL_BASE, zeros + 1]
    else
      [base, zeros]
    end
  end

  def final_value
    base, zeros = base_with_zeros
    remaining_zeros = zeros % ZEROS_PER_PREFIX
    base * DECIMAL_BASE**remaining_zeros
  end

  def prefix
    _, zeros = base_with_zeros
    PREFIXES[zeros / ZEROS_PER_PREFIX]
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

  template_ptbr = "Valor do resistor: %<value>i %<prefix>sohms (PT-BR)"
  puts resistor1.label(template: template_ptbr)
end
