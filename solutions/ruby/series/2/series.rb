class Series

  def initialize(string)
    self.string = string
    
    raise ArgumentError if string.empty?
  end

  private

  attr_accessor :string

  def string=(value)
    @string = value
  end

  public

  def slices(size)
    raise ArgumentError if size > string.length || size <= 0

    string.chars.each_cons(size).map(&:join)
  end
end