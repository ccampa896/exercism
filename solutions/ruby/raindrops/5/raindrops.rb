class Raindrops

  RULES = {
    3 => 'Pling',
    5 => 'Plang',
    7 => 'Plong'
  }

  attr_reader :number

  def initialize(number)
    @number = number
  end

  def sound
    sounds = RULES.each_with_object(String.new) do |(divisor, sound), result_string|
      result_string << sound if (@number % divisor).zero?
    end

    sounds.empty? and @number.to_s or sounds
  end

  def self.convert(number)
    new(number).sound
  end

end

if $PROGRAM_NAME == __FILE__
  puts "Starting the Traceability (Forensics) demonstration...\n\n"

  # We instantiate the raindrop event with the number 15
  drop = Raindrops.new(15)

  # The system extracts the processed result:
  puts "The processed sound was: #{drop.sound}"
  # Expected: "PlingPlang"

  # The magic of Traceability:
  # The system can audit which original number generated that specific sound
  puts "Forensic Audit - The original number was: #{drop.number}"
  # Expected: 15
end
