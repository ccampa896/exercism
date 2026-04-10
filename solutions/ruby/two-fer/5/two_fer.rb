class TwoFer

  TEMPLATE = 'One for %<name>s, one for me.'

  def self.two_fer(name = 'you')
    new(name).to_s
  end

  attr_reader :name
  attr_writer :name

  def initialize(name)
    self.name = name
  end

  def to_s
    format(TEMPLATE, name: name)
  end
  
end