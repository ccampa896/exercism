class Series

  def initialize(sequence)
    self.sequence = sequence
    raise ArgumentError if sequence.empty?
  end

  private

  attr_accessor :sequence

  public

  def slices(size)
    raise ArgumentError if size > sequence.length || size <= 0

    sequence.chars.each_cons(size).map(&:join)
  end

end

if $PROGRAM_NAME == __FILE__
  series = Series.new("49142")

  puts "--- Testing 3-digit slices ---"
  puts series.slices(3)

  puts "\n--- Testing 4-digit slices ---"
  puts series.slices(4)
end
