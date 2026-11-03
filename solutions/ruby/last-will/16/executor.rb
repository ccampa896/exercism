require_relative 'person'

Zhang  = Person.build(8_541, 512, 677)
Khan   = Person.build(4_142, 148, 875)
Garcia = Person.build(4_023, 118, 923)

module EstateExecutor
  extend self

  HEIRS = [Zhang, Khan, Garcia]

  FRAGMENT = ->(color) { HEIRS.sum { |heir| heir.const_get(color).code_fragment } }

  private_constant :HEIRS, :FRAGMENT

  def assemble_account_number(secret)
    HEIRS.sum { |heir| heir.bank_number_part(secret) }
  end

  def assemble_code
    # 1. We map the array of colors passing our FRAGMENT lambda natively (&).
    # 2. We smash/reduce the resulting array of numbers by multiplying them with inject(:*).
    [:Red, :Blue].map(&FRAGMENT).inject(:*)
  end

end
