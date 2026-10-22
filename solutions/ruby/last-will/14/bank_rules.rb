module BankRules
  # Renamed from ACCOUNT to reflect its true mathematical purpose as a divisor
  ACCOUNT_NUMBER_MODULUS = 10_000

  def bank_number_part(secret, client: self)
    client::BASE * secret % ACCOUNT_NUMBER_MODULUS
  end

end
