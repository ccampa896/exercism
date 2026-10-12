module BankRules
  ACCOUNT_MODULO = 10_000
end

module Zhang

  include BankRules

  BASE_PART = 8_541

  def self.bank_number_part(secret)
    BASE_PART * secret % ACCOUNT_MODULO
  end

  module Red
    def self.code_fragment
      512
    end
  end

  module Blue
    def self.code_fragment
      677
    end
  end

end

module Khan

  include BankRules

  BASE_PART = 4_142

  def self.bank_number_part(secret)
    BASE_PART * secret % ACCOUNT_MODULO
  end

  module Red
    def self.code_fragment
      148
    end
  end

  module Blue
    def self.code_fragment
      875
    end
  end

end

module Garcia

  include BankRules

  BASE_PART = 4_023

  def self.bank_number_part(secret)
    BASE_PART * secret % ACCOUNT_MODULO
  end

  module Red
    def self.code_fragment
      118
    end
  end

  module Blue
    def self.code_fragment
      923
    end
  end

end

module EstateExecutor

  HEIRS = [Zhang, Khan, Garcia]

  def self.assemble_account_number(secret)
    HEIRS.sum { |heir| heir.bank_number_part(secret) }
  end

  def self.assemble_code
    red_sum = HEIRS.sum { |heir| heir::Red.code_fragment }
    blue_sum = HEIRS.sum { |heir| heir::Blue.code_fragment }

    red_sum * blue_sum
  end

end
