class TwoFer
  SHARING = 'One for %<name>s, one for me.'

  attr_reader :name
  
  def initialize(name)
    self.name = name
  end

  def self.two_fer(name = 'you')
    new(name).to_s
  end

  def to_s
    SHARING % { name: }
  end

  private

  attr_writer :name
end