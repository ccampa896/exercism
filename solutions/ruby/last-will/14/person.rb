require_relative 'bank_rules'

module Person
  # The Factory: returns a brand new Anonymous Module
  def self.build(base_value, red_code, blue_code)
    Module.new do
      # 1. Bank rules are born with the person. No more external monkey patching!
      extend BankRules

      # 2. Dynamically define the BASE constant
      const_set(:BASE, base_value)

      # 3. Extreme metaprogramming with class_eval
      # We group the data in a Hash and iterate in a single pass to keep it DRY
      { Red: red_code, Blue: blue_code }.each do |color_name, code_value|

        class_eval(<<-RUBY, __FILE__, __LINE__ + 1)

          module #{color_name}
            extend self

            def code_fragment
              #{code_value}
            end

          end
        RUBY

      end

    end

  end

end
