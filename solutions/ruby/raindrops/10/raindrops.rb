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
  attr_accessor :rules, :sound

  def initialize(number, rules: RULES)
    self.number = number
    self.rules = rules

    self.sound = sound_or_number(build_chord)
  end

  def build_chord
    rules.each_with_object(+'') do |(divisor, note), chord|
      chord << note if (number % divisor).zero?
    end
  end

  def sound_or_number(chord)
    chord.empty? ? number : chord
  end

  public

  attr_reader :number

  def to_s
    sound.to_s
  end

  def to_i
    number
  end

  def coerce(other_number)
    [other_number, number]
  end

end

if $PROGRAM_NAME == __FILE__
  puts "Starting the Traceability (Forensics) demonstration...\n\n"

  # We instantiate the raindrop event with the number 15
  drop = Raindrops.new(15)

  # The magic of Native Integration (String Coercion):
  puts 'The processed sound was: %<drop>s' % {drop:}
  # Expected: "PlingPlang"

  # Testing the custom child rules (Suzy and Billy's rules!):
  camp_drop = Raindrops.new(15, rules: {8 => 'Suzy', 10 => 'Billy', 15 => 'Camp!'})
  puts 'The sound with custom camp rules was: %<camp_drop>s' % {camp_drop:}
  # Expected: "Camp!"

  # Comprehensive testing trick: 0 is evenly divisible by all numbers.
  zero_drop = Raindrops.new(0)
  puts 'The sound for 0 (tests all rules) was: %<zero_drop>s' % {zero_drop:}
  # Expected: "PlingPlangPlong"

  # The magic of Native Integer Coercion (Double-Dispatch with coerce):
  # Because we defined coerce, native numbers know how to sum themselves with Raindrops!
  math_result = 10 + drop
  puts 'Double-Dispatch Math - 10 + Raindrop(15): %<math_result>d' % {math_result:}
  # Expected: 25

  # The magic of Traceability (Forensics):
  puts 'Forensic Audit - The original number was: %<number>p' % {number: drop.number}
  # Expected: 15
end
