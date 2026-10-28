require_relative 'person'

# We inject the data into the factory, and Ruby magically binds
# the Anonymous Modules to these Global Constants.
Zhang  = Person.build(8_541, 512, 677)
Khan   = Person.build(4_142, 148, 875)
Garcia = Person.build(4_023, 118, 923)

module EstateExecutor
  extend self

  HEIRS = [Zhang, Khan, Garcia]

  def assemble_account_number(secret)
    HEIRS.sum { |heir| heir.bank_number_part(secret) }
  end

  def assemble_code
    # We extract the iteration and sum logic into a procedure (lambda).
    sum_fragments = ->(color) { HEIRS.sum { |heir| heir.const_get(color).code_fragment } }

    # Now we simply call the lambda twice, passing the desired constant.
    sum_fragments.call(:Red) * sum_fragments.call(:Blue)
  end

end
