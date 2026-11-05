class Raindrops

  RULES = {
    3 => 'Pling',
    5 => 'Plang',
    7 => 'Plong',
  }

  def self.convert(number)
    new(number).to_s
  end

  private

  attr_writer :number
  attr_accessor :rules
  attr_writer :to_s

  def initialize(number, rules: RULES)
    self.number = number
    self.rules = rules
    self.to_s = sound_or_number(chord).to_s
  end

  def chord
    @chord ||= rules.each_with_object(+'') do |(divisor, note), acc|
      acc << note if (number % divisor).zero?
    end
  end

  def sound_or_number(evaluated_chord)
    evaluated_chord.empty? ? number : evaluated_chord
  end

  public

  attr_reader :number, :to_s

  def to_i
    number
  end

  def coerce(other_number)
    [other_number, number]
  end

end

if $PROGRAM_NAME == __FILE__
  puts "Starting the Traceability (Forensics) demonstration...\n\n"

  drop = Raindrops.new(15)

  puts 'The processed sound was: %<drop>s' % {drop:}
  # Expected: "PlingPlang"

  suzy_drop = Raindrops.new(8, rules: {8 => 'Suzy', 10 => 'Billy', 15 => 'Camp!'})
  billy_drop = Raindrops.new(10, rules: {8 => 'Suzy', 10 => 'Billy', 15 => 'Camp!'})
  puts 'Suzy (8) custom rule: %<suzy_drop>s' % {suzy_drop:}
  puts 'Billy (10) custom rule: %<billy_drop>s' % {billy_drop:}
  # Expected: "Suzy", "Billy"

  zero_drop = Raindrops.new(0)
  puts 'The sound for 0 (tests all rules) was: %<zero_drop>s' % {zero_drop:}
  # Expected: "PlingPlangPlong"

  puts "\nDouble Dispatch Math demonstration...\n"

  [3, 5, 7, 15, 30, 45, 105].each do |number|
    drop = Raindrops.new(number)

    math_result = 10 + drop

    result = 'For number %<number>p: 10 + %<drop>s = %<math_result>d'
    puts result % {number:, drop:, math_result:}
  end

  puts "\nForensic Audit - The original number was: %<number>p" % {number: drop.number}
  # Expected: 15
end
