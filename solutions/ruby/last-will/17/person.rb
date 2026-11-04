require_relative 'bank_rules'

module Person

  MODULE_TEMPLATE = <<-RUBY
    module %<color_name>s
      extend self

      def code_fragment
        %<code_value>s
      end

    end
  RUBY

  def self.build(base_value, red_code, blue_code)
    Module.new do
      extend BankRules

      const_set(:BASE, base_value)

      {Red: red_code, Blue: blue_code}.each do |color_name, code_value|

        module_definition = MODULE_TEMPLATE % {code_value:, color_name:}

        class_eval(module_definition, __FILE__, __LINE__.next)

      end

    end

  end

end
