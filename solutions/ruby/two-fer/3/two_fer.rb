class TwoFer

  def initialize(name)
    @name = name
  end

  def to_s
    'One for %s, one for me.' % @name
  end

  def self.two_fer(name = 'you')
    new(name).to_s
  end

end