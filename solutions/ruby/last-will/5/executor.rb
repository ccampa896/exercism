module EstateExecutor

  HEIRS = [Zhang, Khan, Garcia]

  def self.assemble_account_number(secret)
    HEIRS.sum { |heir| heir.bank_number_part(secret, client: heir) }
  end

  def self.assemble_code
    red_sum = HEIRS.sum { |heir| heir::Red.code_fragment }
    blue_sum = HEIRS.sum { |heir| heir::Blue.code_fragment }

    red_sum * blue_sum
  end

end
