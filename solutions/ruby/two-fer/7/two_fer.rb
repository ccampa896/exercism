class TwoFer

  SHARING = 'One for %<name>s, one for me.'

  def self.two_fer(name = 'you')
    new(name).to_s
  end

  private

  attr_accessor :name

  def initialize(name)
    self.name = name
  end

  public

  def to_s
    SHARING % {name:}
  end
end