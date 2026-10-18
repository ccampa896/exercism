module BankRules

  ACCOUNT = 10_000

  def bank_number_part(secret, client: self)
    client::BASE * secret % ACCOUNT
  end

end
