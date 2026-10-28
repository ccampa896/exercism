module BankRules

  def least_significant(number, digits: 4)
    number % (10**digits)
  end

  def bank_number_part(secret, client: self)
    raw_number = client::BASE * secret
    least_significant(raw_number, digits: 4)
  end

end
