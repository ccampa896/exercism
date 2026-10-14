module BankRules

  ACCOUNT = 10_000

  def bank_number_part(secret, client: self)
    client::BASE * secret % ACCOUNT
  end

end

require_relative 'zhang'
require_relative 'khan'
require_relative 'garcia'
require_relative 'executor'
