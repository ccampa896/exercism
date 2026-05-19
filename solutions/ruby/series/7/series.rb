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

  def initialize(sequence)
    raise SequenceEmptyError if sequence.empty?

    self.sequence = sequence
  end

  public

  def slices(size, verbose: false, strict: true)
    result = sequence.chars.each_cons(size).map(&:join)

    unless (1..sequence.length).cover?(size)
      p [sequence, size, result] if verbose

      if strict
        raise SliceSizeError, "Slice size must be between 1 and #{sequence.length}. You provided: #{size}."
      end
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
    puts "Directive Message: #{e.message}"
  end

  puts "\n=== Verbose & Non-Strict Behavior ==="
  puts "User explicitly bypassed the error to get Ruby's native empty array result:"

  result = series.slices(9, verbose: true, strict: false)

  puts "\nFinal Result returned safely: #{result.inspect}"
end
