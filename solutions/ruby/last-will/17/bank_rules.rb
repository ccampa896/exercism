module BankRules

  def client_account(number, digits: 1)
    number % 10**digits
  end

  def bank_number_part(secret, client: self)
    client_account(client::BASE * secret, digits: 4)
  end

end
