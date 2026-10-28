require_relative 'bank_rules'

module Person
  # The Factory: returns an Anonymous Module (respecting test limitations
  # that require Global Constants instead of class instances)
  def self.build(base_value, red_code, blue_code)
    Module.new do
      extend BankRules

      const_set(:BASE, base_value)

      { Red: red_code, Blue: blue_code }.each do |color_name, code_value|

        # Extreme metaprogramming with Heredoc.
        # We pass __FILE__ and __LINE__ + 1 so that the Ruby interpreter
        # maintains exact traceability in case of errors within these sub-modules.
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
