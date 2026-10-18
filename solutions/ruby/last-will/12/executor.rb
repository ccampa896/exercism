require_relative 'bank_rules'
require_relative 'zhang'
require_relative 'khan'
require_relative 'garcia'

module EstateExecutor

  extend self

  HEIRS = [Zhang, Khan, Garcia].map { |heir| heir.extend(BankRules) }

  def assemble_account_number(secret)
    HEIRS.sum { |heir| heir.bank_number_part(secret, client: heir) }
  end

  def assemble_code
    red_sum = HEIRS.sum { |heir| heir::Red.code_fragment }
    blue_sum = HEIRS.sum { |heir| heir::Blue.code_fragment }

    red_sum * blue_sum
  end

end
