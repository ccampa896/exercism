require_relative 'bank_rules'

module Person

  MODULE_LINE = __LINE__ + 2
  MODULE = <<-RUBY
    module %<color>s
      extend self

      def code_fragment
        %<code>s
      end

    end
  RUBY

  private_constant :MODULE, :MODULE_LINE

  def self.build(base_value, red_code, blue_code)
    Module.new do
      extend BankRules

      const_set(:BASE, base_value)

      {Red: red_code, Blue: blue_code}.each do |color, code|
        class_eval(MODULE % {code:, color:}, __FILE__, MODULE_LINE)
      end
    end
  end

end
