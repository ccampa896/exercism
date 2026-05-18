class Series

  private

  attr_accessor :sequence

  def initialize(sequence)
    raise ArgumentError, 'The sequence cannot be empty.' if sequence.empty?

    self.sequence = sequence
  end

  public

  def slices(size)
    unless (1..sequence.length).include?(size)
      raise ArgumentError, "Slice size must be between 1 and #{sequence.length}."
    end

    sequence.chars.each_cons(size).map(&:join)
  end

  def to_s
    "Series(#{sequence})"
  end
end

if $PROGRAM_NAME == __FILE__
  my_data = '49142'
  series = Series.new(my_data)

  report = <<~REPORT
    --- Testing %<digits>s-digit slices ---
    My instance: %<my_instance>p
    My slices: %<slices>p
  REPORT

  [3, 4].each do |digits|
    puts report % {
      digits: digits,
      my_instance: series.to_s,
      slices: series.slices(digits).join(', ')
    }
  end
end
