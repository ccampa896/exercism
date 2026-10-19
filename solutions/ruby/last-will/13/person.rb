require_relative 'bank_rules'

module Person
  # The Factory: returns a brand new Anonymous Module
  def self.build(base_value, red_code, blue_code)
    Module.new do
      # 1. Bank rules are born with the person. No more external monkey patching!
      extend BankRules

      # 2. Dynamically define the BASE constant
      const_set(:BASE, base_value)

      # 3. Dynamically build the Red and Blue sub-modules, capturing
      # the values through the block's lexical scope (closure).
      const_set(:Red, Module.new do
        define_singleton_method(:code_fragment) { red_code }
      end)

      const_set(:Blue, Module.new do
        define_singleton_method(:code_fragment) { blue_code }
      end)

    end

  end

end
