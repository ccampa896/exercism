Series = Data.define(:string) do
  
  def initialize(string:)
    raise ArgumentError if string.empty?
    
    super
  end

  def slices(size)
    raise ArgumentError if size > string.length || size <= 0

    string
      .chars
      .each_cons(size)
      .map(&:join)
  end
end