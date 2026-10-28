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

  def initialize(number, rules = RULES)
    self.number = number
    self.rules = rules
  end

  def sound
    rules.each_with_object(+'') do |(divisor, note), sound|
      sound << note if (number % divisor).zero?
    end
  end

  public

  attr_reader :number

  def to_s
    generated_sound = sound
    generated_sound.empty? ? number.to_s : generated_sound
  end

end

if $PROGRAM_NAME == __FILE__
  puts "Starting the Traceability (Forensics) demonstration...\n\n"

  # We instantiate the raindrop event with the number 15
  drop = Raindrops.new(15)

  # The magic of Native Integration:
  # The %<drop>s format automatically calls the .to_s method on our object!
  puts 'The processed sound was: %<drop>s' % {drop: drop}
  # Expected: "PlingPlang"

  # Dependency Injection Demonstration (Custom Rules):
  # Notice the stylistic choice: no spaces inside Hash delimiters for collections!
  custom_drop = Raindrops.new(15, {3=>'Bim', 5=>'Bom'})
  puts 'The sound with custom rules was: %<drop>s' % {drop: custom_drop}
  # Expected: "BimBom"

  # The magic of Traceability (Forensics):
  # Using %p calls .inspect on the number, displaying its literal value safely.
  puts 'Forensic Audit - The original number was: %<number>p' % {number: drop.number}
  # Expected: 15
end
