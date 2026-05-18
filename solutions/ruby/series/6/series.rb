class Series

  class SequenceEmptyError < ArgumentError
    def initialize(message = 'The sequence cannot be empty.')
      super(message)
    end
  end

  class SliceSizeError < ArgumentError
    def initialize(message = 'Slice size is out of valid range.')
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

  def slices(size)
    raise SliceSizeError unless (1..sequence.length).cover?(size)

    sequence.chars.each_cons(size).map(&:join)
  end

  def to_s
    sequence
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
