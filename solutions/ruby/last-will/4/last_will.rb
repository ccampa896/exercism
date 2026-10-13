module BankRules

  ACCOUNT_MODULO = 10_000

  def bank_number_part(secret, object = self)
    object::BASE_PART * secret % ACCOUNT_MODULO
  end

end

module Zhang

  extend BankRules

  BASE_PART = 8_541

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

  extend BankRules

  BASE_PART = 4_142

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

  extend BankRules

  BASE_PART = 4_023

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
    HEIRS.sum { |heir| heir.bank_number_part(secret, heir) }
  end

  def self.assemble_code
    red_sum = HEIRS.sum { |heir| heir::Red.code_fragment }
    blue_sum = HEIRS.sum { |heir| heir::Blue.code_fragment }

    red_sum * blue_sum
  end

end
