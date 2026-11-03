require_relative 'bank_rules'

module Person

  def self.build(base_value, red_code, blue_code)
    Module.new do
      extend BankRules

      const_set(:BASE, base_value)

      {Red: red_code, Blue: blue_code}.each do |color_name, code_value|

        heredoc = <<-RUBY % {code_value:, color_name:}
          module %<color_name>s
            extend self

            def code_fragment
              %<code_value>s
            end
          end
        RUBY

        class_eval(heredoc, __FILE__, __LINE__.next)

      end

    end

  end

end
