class Raindrops

  RULES = {
    3 => 'Pling',
    5 => 'Plang',
    7 => 'Plong'
  }

  def self.convert(number)
    new(number).to_s
  end

  attr_reader :number

  def initialize(number, rules = RULES)
    self.number = number # Uses the private 'writer' instead of accessing @number directly
    @rules = rules
  end

  def to_s
    generated_sound = build_sound
    generated_sound.empty? ? number.to_s : generated_sound
  end

  private

  attr_writer :number
  attr_reader :rules

  def build_sound
    rules.each_with_object(String.new) do |(divisor, note), sound|
      sound << note if (number % divisor).zero?
    end
  end

end

if $PROGRAM_NAME == __FILE__
  puts "Starting the Traceability (Forensics) demonstration...\n\n"

  # We instantiate the raindrop event with the number 15
  drop = Raindrops.new(15)

  # The magic of Native Integration:
  # The %<sound>s forces Ruby to call our object's to_s method automatically!
  puts 'The processed sound was: %<sound>s' % { sound: drop }
  # Expected: "PlingPlang"

  # Dependency Injection Demonstration (Custom Rules):
  custom_drop = Raindrops.new(15, { 3 => 'Bim', 5 => 'Bom' })
  puts 'The sound with custom rules was: %<sound>s' % { sound: custom_drop }
  # Expected: "BimBom"

  # The magic of Traceability:
  puts 'Forensic Audit - The original number was: %<number>p' % { number: drop.number }
  # Expected: 15
end
