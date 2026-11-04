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

    # Eager Evaluation: The sound is decoded and interpreted
    # the exact moment the drop is born.
    raw_sound = decode_sound
    self.sound = interpret(raw_sound)
  end

  # Responsibility 1 (Private): Only applies the mathematical rules and generates the text.
  def decode_sound
    rules.each_with_object(+'') do |(divisor, note), str|
      str << note if (number % divisor).zero?
    end
  end

  # Responsibility 2 (Private): Only decides the business rule for silence.
  def interpret(generated_sound)
    generated_sound.empty? ? number : generated_sound
  end

  public

  attr_reader :number

  # Pure SRP: The method does exactly and only what it is supposed to do,
  # fully trusting the already interpreted value stored in @sound.
  def to_s
    sound.to_s
  end

  # Duck Typing Extravaganza
  def to_i
    number
  end

end

# TEST AND AUDIT BLOCK (Only runs if invoked directly)
if $PROGRAM_NAME == __FILE__
  puts "Starting the Traceability (Forensics) demonstration..."

  # We instantiate the raindrop event with the number 15
  drop = Raindrops.new(15)

  # The magic of Native Integration & Valueless Hash:
  # The %<drop>s format automatically calls the .to_s method on our object!
  puts 'The processed sound was: %<drop>s' % {drop:}
  # Expected: "PlingPlang"

  # Dependency Injection Demonstration (Custom Rules with Keyword Args):
  # Notice the stylistic choice: no spaces inside Hash delimiters for collections!
  custom_drop = Raindrops.new(15, rules: {3=>'Bim', 5=>'Bom'})
  puts 'The sound with custom rules was: %<custom_drop>s' % {custom_drop:}
  # Expected: "BimBom"

  # Comprehensive testing trick: 0 is evenly divisible by all numbers.
  zero_drop = Raindrops.new(0)
  puts 'The sound for 0 (tests all rules) was: %<zero_drop>s' % {zero_drop:}
  # Expected: "PlingPlangPlong"

  # The magic of Traceability (Forensics):
  # Using %p calls .inspect on the number, displaying its literal value safely for developers.
  puts 'Forensic Audit - The original number was: %<number>p' % {number: drop.number}
  # Expected: 15
end
