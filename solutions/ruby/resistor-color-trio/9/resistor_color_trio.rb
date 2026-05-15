module ResistorDecoding

  begin # private constants

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

    PREFIXES = ['', 'kilo', 'mega', 'giga']

    REPORT = 'Resistor value: %<value>i %<prefix>sohms'

    SIGNIFICANT_BANDS = 3
    ZEROS_PER_PREFIX  = 3

    private_constant :BAND,              :PREFIXES,
                     :SIGNIFICANT_BANDS, :ZEROS_PER_PREFIX
  end

  def label(template: REPORT)
    template % {value: final_value, prefix:}
  end

  private

  def numeric_values
    colors.take(SIGNIFICANT_BANDS).map { |color| BAND[color.to_sym] }
  end

  def base_with_zeros
    tens, ones, multiplier = numeric_values
    base = tens * 10 + ones
    zeros = multiplier

    decimal?(base) and {base: base/10, zeros: zeros.next} or
      {base: base, zeros:}
  end

  def decimal?(base)
    base > 0 && (base % 10).zero?
  end

  def final_value
    data = base_with_zeros
    data[:base] * (10**(data[:zeros] % ZEROS_PER_PREFIX))
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
  
  puts "--- Standard Output ---"
  puts "Using the default REPORT template:"
  puts resistor1
  puts resistor2
  
  puts "\n--- Understanding the Template (REPORT) ---"
  puts "The current public template is: '#{ResistorDecoding::REPORT}'"
  puts "It receives the :value and :prefix keys dynamically."
  
  puts "\n--- Custom Output (Self-Service) ---"
  custom_template = "Base value: %<value>i | Multiplier: %<prefix>s"
  puts resistor1.label(template: custom_template)
end
