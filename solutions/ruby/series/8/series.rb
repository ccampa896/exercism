class Series

  class SequenceEmptyError < ArgumentError
    def initialize(message = 'The sequence cannot be empty.')
      super(message)
    end
  end

  class SliceSizeError < ArgumentError
    def initialize(message = 'Slice size must be between 1 and the length of the sequence.')
      super(message)
    end
  end

  private

  attr_accessor :sequence

  public

  def initialize(sequence)
    raise SequenceEmptyError if sequence.empty?

    self.sequence = sequence
  end

  def length
    sequence.length
  end

  def slices(size, strict: true)
    result = sequence.chars.each_cons(size).map(&:join)

    unless (1..length).cover?(size)
      # Listening to the Ruby environment (e.g., running the script with `ruby -d series.rb`)
      p [sequence, size, result] if $DEBUG || $VERBOSE

      strict and
        raise SliceSizeError,
              "Slice size must be between 1 and #{length}. You provided: #{size}."
    end

    result
  end

  def to_s
    sequence
  end
end

if $PROGRAM_NAME == __FILE__
  series = Series.new('49142')

  puts "=== Normal / Strict Behavior (Raises Error) ==="
  begin
    series.slices(9)
  rescue Series::SliceSizeError => e
    puts "#{e.class}: #{e.message}"
  end

  puts "\n=== Verbose & Non-Strict Behavior ==="
  puts "User explicitly bypassed the error to get Ruby's native empty array result:"

  # Simulating the command-line flag activated just for this block
  $DEBUG = true
  result = series.slices(9, strict: false)
  $DEBUG = false

  puts "\nFinal Result returned safely: #{result.inspect}"
end
