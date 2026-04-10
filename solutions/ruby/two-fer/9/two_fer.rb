SHARING = 'One for %<name>s, one for me.'

TwoFer = Object.new

def TwoFer.two_fer(name = 'you')
  SHARING % {name:}
end